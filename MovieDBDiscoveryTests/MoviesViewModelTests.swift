//
@testable import MovieDBDiscovery
//  MoviesViewModelTests.swift
//  MoviesViewModelTests
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest

class MoviesViewModelTests: XCTestCase {
    var requestHandler: MoviesRequestHandlerProtocol!
    var viewModelDelegateMock: MoviesViewModelDelegateMock!
    var moviesViewModel: MoviesListViewModel!

    override func setUp() {
        super.setUp()
        requestHandler = MoviesRequestHandlerMock()
        viewModelDelegateMock = MoviesViewModelDelegateMock()
        moviesViewModel = MoviesListViewModel(service: requestHandler,
                                              delegate: viewModelDelegateMock)
    }

    override func tearDown() {
        requestHandler = nil
        viewModelDelegateMock = nil
        moviesViewModel = nil
        super.tearDown()
    }

    func testMoviesViewModelInit() {
        let moviesViewModel = MoviesListViewModel(service: requestHandler,
                                                  delegate: viewModelDelegateMock)
        XCTAssertNotNil(moviesViewModel)
    }

    func testMoviesViewModelTestCallsDelegateOnSuccess() {
        moviesViewModel.loadPopularMoviesList()
        XCTAssertTrue(viewModelDelegateMock.moviesLoadedWasCalled)
    }

    func testMoviesViewModelTestFillsMoviesListCorrectly() {
        moviesViewModel.loadPopularMoviesList()
        XCTAssertEqual(moviesViewModel.moviesCount, 1)
        XCTAssertEqual(moviesViewModel.movie(at: 0)!, movieMock)
    }

    func testMoviesViewModelTestSearch() {
        moviesViewModel.searchText = "xxx"
        XCTAssertEqual(moviesViewModel.moviesCount, 2)
        XCTAssertEqual(moviesViewModel.movie(at: 0)!, movieMock)
    }

    func testSetWhiteSpaceSearchTextDoesntExecuteSearch() {
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.searchText = "   "
        XCTAssertEqual(moviesViewModel.moviesCount, countBefore)
    }

    func testResetList() {
        moviesViewModel.loadPopularMoviesList()
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.resetList()
        let countAfter = moviesViewModel.moviesCount
        XCTAssertNotEqual(countAfter, countBefore)
        XCTAssertEqual(countAfter, 0)
    }

    func testRefresh() {
        moviesViewModel.loadPopularMoviesList()
        var countBefore = moviesViewModel.moviesCount
        moviesViewModel.refresh()
        var countAfter = moviesViewModel.moviesCount
        XCTAssertEqual(countAfter, countBefore)

        moviesViewModel.searchText = "xxx"
        countBefore = moviesViewModel.moviesCount
        moviesViewModel.refresh()
        countAfter = moviesViewModel.moviesCount
        XCTAssertEqual(countAfter, countBefore)
    }

    func testCancelSearch() {
        moviesViewModel.searchText = "xxx"
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.cancelSearch()
        let countAfter = moviesViewModel.moviesCount
        XCTAssertNotEqual(countAfter, countBefore)
    }

    func testIsLoadingCallsDelegate() {
        moviesViewModel.isLoading = true
        XCTAssertTrue(viewModelDelegateMock.isLoadingCalled)
    }
}
