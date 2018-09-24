//
//  APISession.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 21.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation
import Alamofire

typealias DataCompletionBlock = (Any?, Error?) -> Void

enum APIEndpoint: String {
    case popularMovies = "discover/movie?sort_by=popularity.desc"
    case movieDetails = "movie/%@"
    case searchMovies = "search/movie?query=%@"

    var baseURL: URL {
        return URL(string:"https://api.themoviedb.org/3/")! //force unwrap is it's a programatic issue if this was nil
    }

    public func toURL(_ arguments: CVarArg...) -> URL {
        let pathString = String(format: self.rawValue, arguments: arguments)
        guard let url = URL(string: pathString, relativeTo: self.baseURL) else {
            fatalError("Unable to construct a service URL for \(pathString)")
        }
        return url
    }
}

protocol APISessionProtocol {
    func getRequest(endpoint: URL, completion: @escaping DataCompletionBlock)
}

public class APISession: APISessionProtocol {

    func getRequest(endpoint: URL, completion: @escaping DataCompletionBlock) {
        Alamofire.request(endpoint,
                          method: .get,
                          parameters:[
                            "language":"en-US",
                            "api_key": "xxx"]) // TODO: to be replaced with the real key
            .validate()
            .responseJSON { response in
                // check for errors, and if the data isn't nil
                guard let json  = response.result.value,
                    response.result.error == nil else {
                        let error = response.result.error
                    // got an error in getting the data, need to handle it
                        print("error calling GET on \(endpoint) with error: \(String(describing: error))")
                    completion(nil, error)
                    return
                }

                completion(json, nil)
        }
    }
}
