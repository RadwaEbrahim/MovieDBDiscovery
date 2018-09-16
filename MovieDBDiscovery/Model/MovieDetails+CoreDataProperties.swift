//
//  MovieDetails+CoreDataProperties.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 16.09.18.
//  Copyright © 2018 RME. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetails> {
        return NSFetchRequest<MovieDetails>(entityName: "MovieDetails")
    }

    @NSManaged public var homepage: String?
    @NSManaged public var runtime: Double
    @NSManaged public var overview: String?
    @NSManaged public var revenue: Double
    @NSManaged public var language: String?

}
