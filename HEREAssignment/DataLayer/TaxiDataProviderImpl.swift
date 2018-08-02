//
//  TaxiDataProviderImpl.swift
//  HEREAssignment
//
//  Created by vnaimark on 8/2/18.
//  Copyright © 2018 vnaimark. All rights reserved.
//

import Foundation
import CoreData

class TaxiDataProviderImpl: TaxiDataProvider {
    
    static let shared = TaxiDataProviderImpl()
    
    private init() {}
    
    func updateTaxiData() {
        let maxETA: UInt32 = 300
        let context = CoreData.shared.mainContext
        context.perform {
            let allTaxis : [Taxi] = (try? CoreData.shared.mainContext.fetch(NSFetchRequest(entityName: "Taxi"))) ?? []
            if allTaxis.isEmpty {
                
                let maxTaxiCount: UInt32 = 20
                let minTaxiCount: UInt32 = 10
                let imageCount: UInt32 = 5
                let count = minTaxiCount + arc4random() % (maxTaxiCount - minTaxiCount)
                for i in 0..<count {
                    let taxi = Taxi(context: context)
                    taxi.taxiID = Int32(i)
                    taxi.eta = Int32(arc4random() % maxETA)
                    taxi.name = "Taxi name \(i)"
                    taxi.imageName = "taxi_\(arc4random() % imageCount + 1)"
                }
            } else {
                let changesCount = arc4random() % UInt32(allTaxis.count)
                var changeIDs : Set<Int> = Set()
                while changeIDs.count < changesCount {
                    changeIDs.insert(Int(arc4random() % UInt32(allTaxis.count)))
                }
                for ID in changeIDs {
                    let request = NSFetchRequest<Taxi>(entityName: "Taxi")
                    request.predicate = NSPredicate(format: "taxiID == %d", ID)
                    let taxi = try? CoreData.shared.mainContext.fetch(request).first
                    if let taxi = taxi {
                        taxi?.eta = Int32(arc4random() % maxETA)
                    }
                }
            }
            context.saveChanges()
        }
    }
}
