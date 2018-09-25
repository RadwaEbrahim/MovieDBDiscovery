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
    var moviesViewModel:MoviesListViewModel!

    override func setUp() {
        super.setUp()
        self.requestHandler = MoviesRequestHandlerMock()
        self.viewModelDelegateMock = MoviesViewModelDelegateMock()
        self.moviesViewModel = MoviesListViewModel(service: self.requestHandler,
                                                  delegate: self.viewModelDelegateMock)
    }
    
    override func tearDown() {
        self.requestHandler = nil
        self.viewModelDelegateMock = nil
        self.moviesViewModel = nil
        super.tearDown()
    }

    func testMoviesViewModelInit() {
        let moviesViewModel = MoviesListViewModel(service: self.requestHandler,
                                                   delegate: self.viewModelDelegateMock)
        XCTAssertNotNil(moviesViewModel)
    }


    func testMoviesViewModelTestCallsDelegateOnSuccess() {
        moviesViewModel.loadMoviesList()
        XCTAssertTrue(viewModelDelegateMock.moviesLoadedWasCalled)
    }

    func testMoviesViewModelTestFillsMoviesListCorrectly() {
        moviesViewModel.loadMoviesList()
        XCTAssertEqual(moviesViewModel.moviesCount, 1)
        XCTAssertEqual(moviesViewModel.movie(at: 0)!, movieMock)
    }

    func testMoviesViewModelTestSearch() {
        moviesViewModel.searchText = "xxx"
        XCTAssertEqual(moviesViewModel.moviesCount, 2)
        XCTAssertEqual(moviesViewModel.movie(at: 0)!, movieMock)
    }

    func testSetWhiteSpaceSearchTextDoesntExecuteSearch(){
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.searchText = "   "
        XCTAssertEqual(moviesViewModel.moviesCount, countBefore)
    }

    func testResetList(){
        moviesViewModel.loadMoviesList()
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.resetList()
        let countAfter = moviesViewModel.moviesCount
        XCTAssertNotEqual(countAfter, countBefore)
        XCTAssertEqual(countAfter, 0)
    }

    func testRefresh() {
        moviesViewModel.loadMoviesList()
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

    func testCancelSearch(){
        moviesViewModel.searchText = "xxx"
        let countBefore = moviesViewModel.moviesCount
        moviesViewModel.cancelSearch()
        let countAfter = moviesViewModel.moviesCount
        XCTAssertNotEqual(countAfter, countBefore)
    }
}

