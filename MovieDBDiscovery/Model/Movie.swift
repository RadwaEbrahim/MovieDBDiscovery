//
import CoreData
//  Movie.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 22.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

@objc(Movie)
public class Movie: NSManagedObject {
    // }
    // struct Movie: Equatable {
//    var id: Int?
//    var title: String?
//    var releaseDate: String?
//    var popularity: Double?
//    var poster: String?
//    var genre: String?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var genre: [String]?
    @NSManaged public var id: NSNumber
    @NSManaged public var popularity: NSNumber
    @NSManaged public var poster: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var homepage: String?
    @NSManaged public var language: String?
    @NSManaged public var overview: String?
    @NSManaged public var revenue: NSNumber
    @NSManaged public var runtime: NSNumber

    enum jsonKeys: String {
        case id
        case title
        case releaseDate = "release_date"
        case popularity
        case poster = "poster_path"
        case genre // needs another call
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    convenience init?(id: NSNumber, title: String?, releaseDate: String?, popularity: NSNumber, poster: String?, genre: [String]?, overview: String? = nil, homepage: String? = nil, runtime: NSNumber = 0, revenue: NSNumber = 0, lang: String? = nil, context: NSManagedObjectContext?) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context!) else {
            print("Error: Failed to create a new movie object!")
            return nil
        }
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.poster = poster
        self.genre = genre
        self.overview = overview
        self.homepage = homepage
        self.runtime = runtime
        self.revenue = revenue
        language = lang
    }

    static func movie(from json: [String: Any], context: NSManagedObjectContext?) -> Movie? {
        let id = json[jsonKeys.id.rawValue] as? Double ?? 0
        let title = json[jsonKeys.title.rawValue] as? String
        let popularity = json[jsonKeys.popularity.rawValue] as? Double ?? 0
        let releaseDate = json[jsonKeys.releaseDate.rawValue] as? String
        let poster = json[jsonKeys.poster.rawValue] as? String
        let genre = json[jsonKeys.genre.rawValue] as? [String]

        return Movie(id: NSNumber(value: id), title: title, releaseDate: releaseDate,
                     popularity: NSNumber(value: popularity), poster: poster, genre: genre, context: context)
    }

    public override func awakeFromInsert() {
        print("here")
    }
}
