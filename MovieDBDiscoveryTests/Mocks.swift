//
//  Mocks.swift
//  MovieDBDiscoveryTests
//
//  Created by Radwa Ibrahim on 23.09.18.
//  Copyright © 2018 RME. All rights reserved.
//
import XCTest
@testable import MovieDBDiscovery

internal class APISessionMock: APISessionProtocol {

    func getRequest(endpoint: URL, completion: @escaping DataCompletionBlock) {
            completion (["results": [movieJson]], nil)
    }
}

internal class MoviesRequestHandlerMock: MoviesRequestHandlerProtocol {

    var session: APISessionProtocol
    init(session: APISessionProtocol = APISessionMock()) {
        self.session = session
    }

    func getPopularMovies(page: Int, completion: @escaping MoviesListCompletionHandler) {
        completion([movieMock], nil)
    }

    func searchMoviesByTitle(title: String, page: Int,
                             completion: @escaping MoviesListCompletionHandler) {
        completion([movieMock, movieMock], nil)
    }
}

class MoviesViewModelDelegateMock: MoviesViewModelDelegate {
    func isLoading(loading: Bool) {
    }

    var moviesLoadedWasCalled = false
    var loadingMoviesFailedWasCalled = false

    func moviesLoadedSuccessfully() {
        moviesLoadedWasCalled = true
    }

    func loadingMoviesFailed(error: Error){
        loadingMoviesFailedWasCalled = true
    }
}
