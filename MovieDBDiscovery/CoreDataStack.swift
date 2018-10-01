//
import CoreData
//  File.swift
//  MovieDBDiscovery
//
//  Created by Radwa Ibrahim on 28.09.18.
//  Copyright © 2018 RME. All rights reserved.
//

import Foundation

class CoreDataStack: NSObject {
    private override init() {}
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieDBDiscovery")

        container.loadPersistentStores(completionHandler: { _, error in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()
}
