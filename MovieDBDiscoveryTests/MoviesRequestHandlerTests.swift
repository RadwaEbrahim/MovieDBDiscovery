//
//  MoviesRequestHandlerTests.swift
//  MoviesRequestHandlerTests
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest
@testable import MovieDBDiscovery

class MoviesRequestHandlerTests: XCTestCase {
    var requestHandler: MoviesRequestHandler!
    var viewModelDelegateMock: MoviesViewModelDelegateMock!
    var moviesViewModel: MoviesListViewModel!

    override func setUp() {
        super.setUp()
        self.requestHandler = MoviesRequestHandler(session: APISessionMock())
        self.viewModelDelegateMock = MoviesViewModelDelegateMock()
        self.moviesViewModel = MoviesListViewModel(service: MoviesRequestHandlerMock(),
                                                  delegate: viewModelDelegateMock)
    }
    
    override func tearDown() {
        self.requestHandler = nil
        self.viewModelDelegateMock = nil
        self.moviesViewModel = nil
        super.tearDown()
    }
    
    func testRequestHandlerCallsAPISession() {
        self.requestHandler.getPopularMovies() { json, error in
            XCTAssertNil(error)
            XCTAssertNotNil(json)
        }
    }

    func moviesViewModelTestCallsDelegateOnSuccess() {
        self.moviesViewModel.loadMoviesList()
        XCTAssertTrue(self.viewModelDelegateMock.moviesLoadedWasCalled)
        XCTAssertEqual(self.moviesViewModel.moviesCount, 0)
    }
}

