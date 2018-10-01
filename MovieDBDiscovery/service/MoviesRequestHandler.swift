//
import CoreData
//  MoviesRequestHandler.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 21.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

typealias MoviesListCompletionHandler = ([Movie]?, Int, Error?) -> Void

protocol MoviesRequestHandlerProtocol {
    func getPopularMovies(page: Int, completion: @escaping MoviesListCompletionHandler)
    func searchMoviesByTitle(title: String, page: Int, completion: @escaping MoviesListCompletionHandler)
    var session: APISessionProtocol { get }
}

class MoviesRequestHandler: MoviesRequestHandlerProtocol {
    var session: APISessionProtocol
    let persistentContainer: NSPersistentContainer

    init(session: APISessionProtocol = APISession(),
         persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer) {
        self.session = session
        self.persistentContainer = persistentContainer
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getPopularMovies(page: Int, completion: @escaping MoviesListCompletionHandler) {
        print("url \(APIEndpoint.popularMovies.toURL(page))")
        session.getRequest(endpoint: APIEndpoint.popularMovies.toURL(page)) { json, error in

            guard error == nil else {
                completion(nil, 0, error)
                return
            }

            guard let json = json as? [String: Any],
                let results = json["results"] as? [[String: Any]],
                let totalsPages = json["total_pages"] as? Int else {
                completion(nil, 0, nil)
                return
            }
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            let success = self.syncMovies(jsonDictionary: results, taskContext: taskContext)
            // let moviesList = results.compactMap { Movie(from: $0, context: taskContext) }

            completion(success, totalsPages, nil)
            // TODO: Read/write from DB, and return array of model objects
        }
    }

    func searchMoviesByTitle(title: String, page: Int, completion: @escaping MoviesListCompletionHandler) {
        let endpoint = APIEndpoint.searchMovies.toURL(title, page)
        session.getRequest(endpoint: endpoint) { json, error in

            guard error == nil else {
                completion(nil, 0, error)
                return
            }

            guard let json = json as? [String: Any],
                let results = json["results"] as? [[String: Any]],
                let totalsPages = json["total_pages"] as? Int else {
                completion(nil, 0, nil)
                return
            }
            let moviesList = results.compactMap { Movie.movie(from: $0, context: nil) }
            completion(moviesList, totalsPages, nil)
            // TODO: Read/write from DB, and return array of model objects
        }
    }

    private func syncMovies(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> [Movie] {
        var successfull = false
        var movies: [Movie] = []

        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            let episodeIds = jsonDictionary.map { $0["id"] as? Int }.compactMap { $0 }
            matchingEpisodeRequest.predicate = NSPredicate(format: "id in %@", argumentArray: [episodeIds])

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs

            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }

            // Create new records.
            for filmDictionary in jsonDictionary {
                guard let movie = Movie.movie(from: filmDictionary, context: taskContext) else {
                    print("Error: Could not batch delete existing records.")
                    return
                }
                movies.append(movie)
            }

            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                //taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }
        return movies
    }
}
