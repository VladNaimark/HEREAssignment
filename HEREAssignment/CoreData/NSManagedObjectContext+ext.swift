//
//  NSManagedObjectContext+ext.swift
//  HEREAssignment
//
//  Created by vnaimark on 8/2/18.
//  Copyright © 2018 vnaimark. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func saveChanges () {
        if hasChanges {
            do {
                try save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
