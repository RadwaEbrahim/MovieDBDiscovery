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
    var searchText: String? { get set }
}

protocol MoviesViewModelDelegate {
    func isLoading(loading: Bool)
    func moviesLoaded()
    func loadingMoviesFailed(error: Error)
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

    var searchText: String? {
        didSet {
            guard let string = searchText?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !string.isEmpty else {
                print("empty string, won't execute search.")
                return
            }
            self.searchMovie(with: searchText!)
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.delegate?.isLoading(loading: isLoading)
        }
    }

    func movieAtIndex(index: Int) -> Movie? {
        return moviesList?[index] ?? nil
    }

    func loadMoviesList() {
        isLoading = true
        service.getPopularMovies(){ [weak self] moviesList, error in
            guard error == nil else {
                self?.delegate?.loadingMoviesFailed(error: error!)
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
        isLoading = false
    }

    func searchMovie(with title: String) {
        isLoading = true
        service.searchMoviesByTitle(title: title) { [weak self] moviesList, error in
            guard error == nil else {
                self?.delegate?.loadingMoviesFailed(error: error!)
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
        isLoading = false
    }
}
