//
//  MoviesListViewModel.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 22.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

enum MovieListType {
    case popular
    case searchResults
}

protocol MoviesListViewModelProtocol {
    func loadMoviesList()
    func movieAtIndex(index: Int)-> Movie?
    func cancelSearch()
    func refresh()
    var moviesCount: Int { get }
    var searchText: String? { get set }
}

protocol MoviesViewModelDelegate {
    func isLoading(loading: Bool)
    func moviesLoaded()
    func loadingMoviesFailed(error: Error)
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    private var moviesList: [Movie]? = []
    private var service: MoviesRequestHandlerProtocol
    private var delegate: MoviesViewModelDelegate?
    private var page: Int = 1
    private var movieListType: MovieListType = .popular {
        didSet {
            page = 1
            self.moviesList?.removeAll()
        }
    }

    init(service: MoviesRequestHandlerProtocol, delegate: MoviesViewModelDelegate?) {
        self.service = service
        self.delegate = delegate
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
            resetList()
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

    func cancelSearch() {
        resetList()
        movieListType = .popular
        loadMoviesList()
    }

    func resetList() {
        moviesList?.removeAll()
        page = 1
    }

    func refresh() {
        if !isLoading {
            isLoading = true
            resetList()

            switch movieListType {
            case .popular:
                loadMoviesList()
            case .searchResults:
                if searchText != nil && !(searchText!.isEmpty) {
                    searchMovie(with: searchText!)
                }
            }
        }
    }

    func loadMoviesList() {
        isLoading = true
        service.getPopularMovies(page: page){ [weak self] moviesList, error in
            self?.isLoading = false

            guard error == nil else {
                self?.delegate?.loadingMoviesFailed(error: error!)
                return
            }
            guard let moviesList = moviesList else {
                print("Empty movies list is returned, nothing to show.")
                return
            }
            self?.moviesList?.append(contentsOf: moviesList)
            self?.delegate?.moviesLoaded()
            self?.page += 1
            return
        }
    }

    func searchMovie(with title: String) {
        isLoading = true
        service.searchMoviesByTitle(title: title, page: page) { [weak self] moviesList, error in
            self?.isLoading = false

            guard error == nil else {
                self?.delegate?.loadingMoviesFailed(error: error!)
                return
            }
            guard let moviesList = moviesList else {
                print("Empty movies list is returned, nothing to show.")
                return
            }
            self?.moviesList?.append(contentsOf: moviesList)
            self?.delegate?.moviesLoaded()
            self?.page += 1
            return
        }
    }
}
