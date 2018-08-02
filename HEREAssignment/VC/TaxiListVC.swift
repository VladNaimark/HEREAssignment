//
//  TaxiListVC.swift
//  HEREAssignment
//
//  Created by vnaimark on 8/2/18.
//  Copyright © 2018 vnaimark. All rights reserved.
//

import UIKit
import CoreData

class TaxiListVC: UIViewController {

    private let taxiDataProvider: TaxiDataProvider = TaxiDataProviderImpl.shared
    private var updateTimer: Timer?
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var frcDelegate = FRCDelegateImpl(tableView)
    private lazy var frc: NSFetchedResultsController<Taxi> = {
        let fetchRequest = NSFetchRequest<Taxi>(entityName: "Taxi")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "eta", ascending: true)]
        
        let frc = NSFetchedResultsController<Taxi>(fetchRequest: fetchRequest,
                                                   managedObjectContext: CoreData.shared.mainContext,
                                                   sectionNameKeyPath: nil,
                                                   cacheName: nil)
        frc.delegate = frcDelegate
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        try! frc.performFetch()
        
        taxiDataProvider.updateTaxiData()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] (timer) in
            self?.taxiDataProvider.updateTaxiData()
        })
    }
}

extension TaxiListVC: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taxi = frc.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaxiCell") ?? UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "TaxiCell")
        cell.imageView?.image = taxi.image
        cell.textLabel?.text = taxi.name
        cell.detailTextLabel?.text = taxi.etaString
        return cell
    }
}
