//
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

    init(session: APISessionProtocol = APISession()) {
        self.session = session
    }

    func getPopularMovies(page: Int, completion: @escaping MoviesListCompletionHandler){
        print("url \(APIEndpoint.popularMovies.toURL(page))")
        self.session.getRequest(endpoint: APIEndpoint.popularMovies.toURL(page)){ json, error in

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
            let moviesList = results.compactMap { Movie(from: $0) }
            completion(moviesList, totalsPages, nil)
            //TODO: Read/write from DB, and return array of model objects
        }
    }

    func searchMoviesByTitle(title: String, page: Int, completion: @escaping MoviesListCompletionHandler) {
        let endpoint = APIEndpoint.searchMovies.toURL(title, page)
        self.session.getRequest(endpoint: endpoint){ json, error in

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
            let moviesList = results.compactMap { Movie(from: $0) }
            completion(moviesList, totalsPages, nil)
            //TODO: Read/write from DB, and return array of model objects
        }
    }

}
