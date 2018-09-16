//
//  Movie+CoreDataProperties.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var popularity: Double
    @NSManaged public var poster: String?
    @NSManaged public var genre: NSObject?

}
