//
//  Movie.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 22.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

struct Movie: Equatable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var popularity: Double?
    var poster: String?
    var genre: String?

    enum jsonKeys: String {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case popularity = "popularity"
        case poster = "poster_path"
        case genre = "genre_ids" //needs another call
    }

    init(id: Int?, title: String?, releaseDate: String?, popularity: Double?, poster: String?, genre: String?) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.poster = poster
        self.genre = genre
    }

    init?(from json: [String: Any]) {
        let id = json[jsonKeys.id.rawValue] as? Int
        let title = json[jsonKeys.title.rawValue] as? String
        let popularity = json[jsonKeys.popularity.rawValue] as? Double
        let releaseDate = json[jsonKeys.releaseDate.rawValue] as? String
        let poster = json[jsonKeys.poster.rawValue] as? String
        let genre = json[jsonKeys.genre.rawValue] as? String

        self.init(id: id, title: title, releaseDate: releaseDate, popularity: popularity, poster: poster, genre: genre)
    }
}
