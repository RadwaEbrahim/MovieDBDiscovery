//
//  MoviesRequestHandlerTests.swift
//  MovieDBDiscoveryTests
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest
@testable import MovieDBDiscovery

class MoviesRequestHandlerTests: XCTestCase {

    func testInitRequestHandlerWithAPISession() {
        let handler = MoviesRequestHandler(session: APISessionMock())
        XCTAssertNotNil(handler)
        XCTAssertNotNil(handler.session)
    }

    func testRequestHandlerGetPopularMovies() {
        let handler = MoviesRequestHandler(session: APISessionMock())
        handler.getPopularMovies(page: 0) { json, error in
            XCTAssertNil(error)
            XCTAssertNotNil(json)
        }
    }

    func testRequestHandlerSearchMovies() {
        let handler = MoviesRequestHandler(session: APISessionMock())

        handler.searchMoviesByTitle(title: "xxx", page: 0) { movies, error in
            XCTAssertNil(error)
            XCTAssertNotNil(movies)
        }
    }

}
