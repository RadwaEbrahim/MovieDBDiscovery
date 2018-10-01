//
//  TestData.swift
//  MovieDBDiscoveryTests
//
//  Created by Radwa Ibrahim on 24.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation
@testable import MovieDBDiscovery

internal var movieJson: [String: Any?] {
    return [
        "vote_count": 0,
        "id": 549_917,
        "video": false,
        "vote_average": 0,
        "title": "1987: Untracing The Conspiracy",
        "popularity": 0,
        "poster_path": nil,
        "original_language": "en",
        "original_title": "1987: Untracing The Conspiracy",
        "genre_ids": [],
        "backdrop_path": nil,
        "adult": false,
        "overview": "In 1987, the Singapore government, using the Internal Security Act, arrested 22 people in what was called \"Operation Spectrum\". These people were held indefinitely without trial, physically and mentally tortured, and coerced into admitting that they were guilty of a \"Marxist conspiracy\" on public television. In this film, ex-detainees share what they experienced during that time.",
        "release_date": "",
    ]
}

internal var movieMock: Movie {
    return Movie(id: 111, title: "title", releaseDate: "1992-08-08", popularity: 33, poster: "", genre: nil)
}

internal var movieViewModelMock: MovieViewModel {
    return MovieViewModel(movie: movieMock)
}
