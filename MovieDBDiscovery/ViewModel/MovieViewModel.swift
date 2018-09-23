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
        self.id = movie.id
        self.title = movie.title
        if movie.releaseDate != nil {
            let dataStringArray = movie.releaseDate?.components(separatedBy: "-")
            self.releaseDate = dataStringArray?[0]
        }
        if movie.popularity != nil {
            self.popularity = String(format: "%.1f", movie.popularity!)
        }
        if movie.poster != nil {
            self.posterURL = URL(string: MovieViewModel.baseImageURL + movie.poster!)!
        }
        self.genre = movie.genre
    }
}
