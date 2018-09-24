//
//  MoviesViewModelTests.swift
//  MoviesViewModelTests
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest
@testable import MovieDBDiscovery

class MoviesViewModelTests: XCTestCase {
    var requestHandler: MoviesRequestHandlerProtocol!
    var viewModelDelegateMock: MoviesViewModelDelegateMock!

    override func setUp() {
        super.setUp()
        self.requestHandler = MoviesRequestHandlerMock()
        self.viewModelDelegateMock = MoviesViewModelDelegateMock()
    }
    
    override func tearDown() {
        self.requestHandler = nil
        self.viewModelDelegateMock = nil
        super.tearDown()
    }

    func testInitRequestHandlerWithAPISession() {
        let handler = MoviesRequestHandler(session: APISession())
        XCTAssertNotNil(handler)
        XCTAssertNotNil(handler.session)
    }

    func testRequestHandlerCallsAPISession() {
        self.requestHandler.getPopularMovies() { json, error in
            XCTAssertNil(error)
            XCTAssertNotNil(json)
        }
    }

    func testMoviesViewModelInit() {
        let moviesViewModel = MoviesListViewModel(service: self.requestHandler,
                                                   delegate: self.viewModelDelegateMock)
        XCTAssertNotNil(moviesViewModel)
    }


    func testMoviesViewModelTestCallsDelegateOnSuccess() {
        let moviesViewModel = MoviesListViewModel(service: self.requestHandler,
                                                  delegate: self.viewModelDelegateMock)
        moviesViewModel.loadMoviesList()
        XCTAssertTrue(viewModelDelegateMock.moviesLoadedWasCalled)
    }

    func testMoviesViewModelTestFillsMoviesListCorrectly() {
        let moviesViewModel = MoviesListViewModel(service: self.requestHandler,
                                                  delegate: self.viewModelDelegateMock)
        moviesViewModel.loadMoviesList()
        XCTAssertEqual(moviesViewModel.moviesCount, 1)
        XCTAssertEqual(moviesViewModel.movieAtIndex(index: 0)!, movieMock)
    }

}

