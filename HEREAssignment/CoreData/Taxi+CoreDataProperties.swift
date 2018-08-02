//
//  Taxi+CoreDataProperties.swift
//  HEREAssignment
//
//  Created by vnaimark on 8/2/18.
//  Copyright © 2018 vnaimark. All rights reserved.
//
//

import UIKit
import CoreData


extension Taxi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Taxi> {
        return NSFetchRequest<Taxi>(entityName: "Taxi")
    }

    @NSManaged public var eta: Int32
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var taxiID: Int32
    
    public var image: UIImage? {
        get {
            guard let imageName = imageName else {
                return nil
            }
            return UIImage(named: imageName)
        }
    }
    
    public var etaString: String {
        get {
            if eta >= 60 {
                return "\(eta / 60)h " + String(format: "%02dm", eta % 60)
            } else {
                return "\(eta % 60)m"
            }
        }
    }
}
