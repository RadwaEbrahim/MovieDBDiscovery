//
//  MovieCellTests.swift
//  MovieDBDiscoveryTests
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import XCTest
@testable import MovieDBDiscovery

class MovieCellTests: XCTestCase {
    var controller: MoviesViewController!
    override func setUp() {
        super.setUp()
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle(for: MoviesViewController.self))
            .instantiateInitialViewController() as? MoviesViewController else {
                return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        vc.viewModel = MoviesListViewModel(service: MoviesRequestHandlerMock(), delegate: nil)
        controller = vc
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        controller = nil
        super.tearDown()
    }

    func testConfigureCell() {
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configure(with: movieViewModelMock)
        XCTAssertEqual(cell.title.text, movieViewModelMock.title)
        XCTAssertEqual(cell.date.text, movieViewModelMock.releaseDate)
        XCTAssertEqual(cell.score.text, movieViewModelMock.popularity)
    }

}
