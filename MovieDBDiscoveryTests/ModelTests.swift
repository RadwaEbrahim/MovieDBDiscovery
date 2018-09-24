//
//  ModelTests.swift
//  MovieDBDiscoveryTests
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest
@testable import MovieDBDiscovery

class ModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieInit() {
        let movie = Movie(from: movieJson as [String : Any])
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.popularity, nil)
        XCTAssertEqual(movie?.title, movieJson["title"] as? String)
        XCTAssertEqual(movie?.id, (movieJson["id"] as? Int))
        XCTAssertEqual(movie?.releaseDate, "")
        XCTAssertNil(movie?.poster)
    }


    func testMovieViewModelInitWithMovie() {
        let movieViewModel = MovieViewModel(movie: movieMock)
        XCTAssertNotNil(movieViewModel)
        XCTAssertEqual(movieViewModel.popularity, "33.0")
        XCTAssertEqual(movieViewModel.title, movieMock.title)
        XCTAssertEqual(movieViewModel.id, movieMock.id)
        XCTAssertEqual(movieViewModel.releaseDate, "1992")
        XCTAssertNil(movieViewModel.posterURL)
    }
}
