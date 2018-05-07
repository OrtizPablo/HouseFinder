//
//  MenuViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    let cells = ["HouseCell", "TransportationCell", "SupermarketCell", "SummaryCell"]

    var house = House()
    var userStops: [Transportation] = []
    var supermarkets: [Supermarket] = [Supermarket(name: "Tesco", check: false, image: UIImage(named: "tescoIcon")), Supermarket(name: "Sainsbury's", check: false, image: UIImage(named: "sainsburysIcon")), Supermarket(name: "Aldi", check: false, image: UIImage(named: "aldiIcon")), Supermarket(name: "Asda", check: false, image: UIImage(named: "asdaIcon")), Supermarket(name: "Lidl", check: false, image: UIImage(named: "lidlIcon")), Supermarket(name: "Waitrose", check: false, image: UIImage(named: "waitroseIcon")), Supermarket(name: "Others", check: false, image: UIImage(named: "othersIcon"))]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    // Number of sections of the menu table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 4 rows are only required for this table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    // Deselect row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && (tableView.cellForRow(at: indexPath)?.isSelected)! {
            self.performSegue(withIdentifier: "HouseSegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 1 && (tableView.cellForRow(at: indexPath)?.isSelected)! {
            self.performSegue(withIdentifier: "TransportationSegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 2 && (tableView.cellForRow(at: indexPath)?.isSelected)! {
            self.performSegue(withIdentifier: "SupermarketSegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row == 3 && (tableView.cellForRow(at: indexPath)?.isSelected)! {
            self.performSegue(withIdentifier: "SummarySegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // Depending on the number of the row the function returns a different kind of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath)
        }
        else if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath)
        }
        else if indexPath.row == 2 {
            return tableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath)
        }
        else {
            return tableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath)
        }
    }
    
    // MARK: Actions
    
    @IBAction func addHouseUnwindSegue(_ sender: UIStoryboardSegue){
        // Getting the properties of the house
        if let senderVC = sender.source as? HouseViewController {
            self.house = senderVC.house
        }
    }
    
    @IBAction func addStationUnwindSegue(_ sender: UIStoryboardSegue){
        // Getting the properties of the transportation
        if let senderVC = sender.source as? TransportationViewController {
            self.userStops = senderVC.userStops
        }
    }
    
    @IBAction func addSupermarketUnwindSegue(_ sender: UIStoryboardSegue){
        if let senderVC = sender.source as? SupermarketViewController {
            self.supermarkets = senderVC.supermarkets
        }
//        print("house: \(house.name)-\(house.roomsNumber)-\(house.bathsNumber)-\(house.rating)-\(house.latitude)-\(house.longitude)")
//        for transportation in userStops {
//            print("Transportation: \(transportation.line) - \(transportation.stop)")
//        }
//        for supermarket in supermarkets {
//            print("Supermarkets: \(supermarket.name) - \(supermarket.check)")
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HouseSegue" {
            let houseViewController = segue.destination as! HouseViewController
            houseViewController.house = self.house
            
        }
        else if segue.identifier == "TransportationSegue" {
            let transportationViewController = segue.destination as! TransportationViewController
            transportationViewController.userStops = self.userStops
        }
        else if segue.identifier == "SupermarketSegue" {
            let supermarketViewController = segue.destination as! SupermarketViewController
            supermarketViewController.supermarkets = self.supermarkets
        }
        else if segue.identifier == "SummarySegue" {
            let summaryViewController = segue.destination as! SummaryViewController
            summaryViewController.house = self.house
            summaryViewController.transportations = self.userStops
            summaryViewController.supermarkets = self.supermarkets
        }
    }
    
    // Function that adds a property to the property list
}
