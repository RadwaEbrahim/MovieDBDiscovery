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

class MoviesListViewModel: MoviesListViewModelProtocol {
    private var moviesList: [Movie]? = []
    private var service: MoviesRequestHandlerProtocol
    private var delegate: MoviesViewModelDelegate?
    private var nextPage: Int = 1
    private var totalPages: Int = 0
    private var movieListType: MovieListType = .popular {
        didSet {
            resetList()
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
            movieListType = .searchResults
            searchMovie(with: searchText!)
        }
    }

    var isLoading: Bool = false {
        didSet {
            delegate?.isLoading(loading: isLoading)
        }
    }

    func movie(at index: Int) -> Movie? {
        return moviesList?[index] ?? nil
    }

    func cancelSearch() {
        movieListType = .popular
        loadPopularMoviesList()
    }

    func resetList() {
        moviesList?.removeAll()
        nextPage = 1
    }

    func refresh() {
        // Check if currently loading a list, then do nothing
        if !isLoading {
            isLoading = true
            resetList()
            loadMoviesList()
        }
    }

    func loadNextPage() {
        /// if we have more pages to retieve.
        if nextPage <= totalPages {
            /// Check if currently loading a list, then do nothing.
            if !isLoading {
                isLoading = true
                loadMoviesList()
            }
        }
    }

    private func loadMoviesList() {
        switch movieListType {
        case .popular:
            loadPopularMoviesList()
        case .searchResults:
            if searchText != nil && !(searchText!.isEmpty) {
                searchMovie(with: searchText!)
            }
        }
    }

    func loadPopularMoviesList() {
        isLoading = true
        service.getPopularMovies(page: nextPage){ [weak self] moviesList, totalPages, error in
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
            self?.delegate?.moviesLoadedSuccessfully()
            self?.nextPage += 1
            self?.totalPages = totalPages
            return
        }
    }

    private func searchMovie(with title: String) {
        isLoading = true
        service.searchMoviesByTitle(title: title, page: nextPage) { [weak self] moviesList,
            totalPages, error in
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
            self?.delegate?.moviesLoadedSuccessfully()
            self?.nextPage += 1
            self?.totalPages = totalPages
            return
        }
    }
}
