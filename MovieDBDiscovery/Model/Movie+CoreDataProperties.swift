//
import CoreData
//  Movie+CoreDataProperties.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 28.09.18.
//  Copyright © 2018 RME. All rights reserved.
//
//

import Foundation

extension Movie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var genre: NSObject?
    @NSManaged public var id: Int64
    @NSManaged public var popularity: Double
    @NSManaged public var poster: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var homepage: String?
    @NSManaged public var language: String?
    @NSManaged public var overview: String?
    @NSManaged public var revenue: Double
    @NSManaged public var runtime: Double
}
