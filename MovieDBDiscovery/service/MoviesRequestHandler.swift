//
//  MoviesRequestHandler.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 21.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

typealias MoviesListCompletionHandler = (Any?, Error?) -> Void //TODO: return list of movies instead

class MoviesRequestHandler {
    func getPopularMovies(completion: @escaping MoviesListCompletionHandler){
        APISession().getRequest(endpoint: APIEndpoint.popularMovies.toURL()){ json,error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let json = json else {
                completion(nil, nil)
                return
            }
            //TODO: Read/write from DB, and return array of model objects
        }


    }
}
