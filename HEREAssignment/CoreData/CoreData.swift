//
//  CoreData.swift
//  HEREAssignment
//
//  Created by vnaimark on 8/2/18.
//  Copyright © 2018 vnaimark. All rights reserved.
//

import Foundation
import CoreData

class CoreData {
    
    static let shared = CoreData()
    
    lazy var mainContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HEREAssignment")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
