//
//  MoviesRequestHandler.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 21.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

typealias MoviesListCompletionHandler = ([Movie]?, Error?) -> Void

protocol MoviesRequestHandlerProtocol {
    func getPopularMovies(completion: @escaping MoviesListCompletionHandler)
    var session: APISessionProtocol { get set }
}
class MoviesRequestHandler: MoviesRequestHandlerProtocol {
    var session: APISessionProtocol


    init(session: APISessionProtocol = APISession()) {
        self.session = session
    }

    func getPopularMovies(completion: @escaping MoviesListCompletionHandler){
        APISession().getRequest(endpoint: APIEndpoint.popularMovies.toURL()){ json,error in

            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let json = json as? [String: Any],
            let results = json["results"] as? [[String: Any]] else {
                completion(nil, nil)
                return
            }
            let moviesList = results.compactMap { Movie(from: $0) }
            completion(moviesList, nil)
            //TODO: Read/write from DB, and return array of model objects
        }
    }
}
