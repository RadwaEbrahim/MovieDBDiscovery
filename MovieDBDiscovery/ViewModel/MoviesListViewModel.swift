//
//  MoviesListViewModel.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 22.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

protocol MoviesListViewModelProtocol {
    func loadMoviesList()
    func movieAtIndex(index: Int)-> Movie?
    var moviesCount: Int { get }
}

protocol MoviesViewModelDelegate {
    func moviesLoaded()
    func loadingMoviesFailed(error: Error)
}
enum APIError : Error {
    case requestFailed
    var localizedDescription: String {
        return NSLocalizedString(
            "Retrieve Popular movies list failed. Please try again and contact us if it is still doesn't work.",
            comment: "Retrieve Popular movies list failed. Please try again and contact us if it is still doesn't work.")
    }
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    private var moviesList: [Movie]?
    private var service: MoviesRequestHandlerProtocol
    private var delegate: MoviesViewModelDelegate?

    init(service: MoviesRequestHandlerProtocol, delegate: MoviesViewModelDelegate?) {
        self.service = service
        self.delegate = delegate
        self.loadMoviesList()
    }

    var moviesCount: Int {
        return moviesList?.count ?? 0
    }

    func movieAtIndex(index: Int) -> Movie? {
        return moviesList?[index] ?? nil
    }

    func loadMoviesList() {
        service.getPopularMovies(){ [weak self] moviesList, error in
            guard error == nil else {
                ///Since not all errors are tested to return a human readable localised error message, We are showing a general one.
                self?.delegate?.loadingMoviesFailed(error: APIError.requestFailed)
                return
            }
            guard let moviesList = moviesList else {
                print("Empty movies list is returned, nothing to show.")
                return
            }
            self?.moviesList = moviesList
            self?.delegate?.moviesLoaded()
            return
        }
    }
}
