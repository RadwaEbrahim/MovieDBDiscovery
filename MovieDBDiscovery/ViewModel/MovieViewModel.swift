//
//  MovieViewModel.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 23.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation
class MovieViewModel {
    static let baseImageURL = "https://image.tmdb.org/t/p/w185"

    var id: String?
    var title: String?
    var releaseDate: String?
    var popularity: String?
    var posterURL: URL?
    var genre: String?

    init(movie: Movie) {
        id = movie.id.stringValue
        title = movie.title
        if movie.releaseDate != nil && !(movie.releaseDate!.isEmpty) {
            let dataStringArray = movie.releaseDate?.components(separatedBy: "-")
            releaseDate = dataStringArray?[0]
        }
        popularity = movie.popularity.stringValue // String(format: "%.1f", movie.popularity)

        if movie.poster != nil && !(movie.poster!.isEmpty) {
            posterURL = URL(string: MovieViewModel.baseImageURL + movie.poster!)!
        }

        genre = "" // movie.genre?.reduce(into: ) { genre, string in
//            &genre += string
//        }
    }
}
