//
//  MoviesListViewModelProtocol.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 25.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

internal protocol MoviesListViewModelProtocol {
    /// Loads Popular movies list and if call the delegate moviesLoaded()
    /// on succeed or loadingMoviesFailed() on error
    func loadPopularMoviesList()

    /// Gets the movie at index from movies List if available
    ///
    /// - Parameter index: Index of the movie.
    /// - Returns: Movie struct if exist, nil otherwise.
    func movie(at index: Int) -> Movie?

    /// Cancels the active search, hides the search results if any
    /// and shows the list of popular movies.
    func cancelSearch()

    /// Refreshes the current shown list of Movies by reseting it and retrieve
    /// any recent update of it.
    func refresh()

    /// Loads the next page of the Current shown movieList
    ///
    func loadNextPage()

    /// Gets the count of the MoviesList for the current shown or about to show list
    var moviesCount: Int { get }

    /// The text to use for searching movies by title
    var searchText: String? { get set }
}

internal protocol MoviesViewModelDelegate {
    /// Updates the current status of loading the movies list.
    ///
    /// - Parameter loading: true if is currently loading, false otherwise.
    func isLoading(loading: Bool)

    /// Called when loading moviesList is done successfully
    func moviesLoadedSuccessfully()

    /// Called when loading moviesList fails with error.
    ///
    /// - Parameter error: error that the request to retieve the data faild with.
    func loadingMoviesFailed(error: Error)
}
