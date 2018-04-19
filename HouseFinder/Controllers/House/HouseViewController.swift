//
//  HouseViewController.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 10/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit
import CoreLocation

class HouseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    let cells = ["NameCell", "RoomsCell", "BathsCell", "RatingCell", "LocationCell"]
    var checkLocation = false
    
    // House properties
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var house = House()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "House"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView functions
    
    // Number of sections of the menu table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath)
        }
        if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath)
        }
        if indexPath.row == 2 {
            return tableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath)
        }
        if indexPath.row == 3 {
            return tableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath)
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! HouseLocationTableViewCell
            // If the location has been inserted
            if checkLocation {
                cell.checkLocation.image = UIImage(named: "TicIcon")
            }
            else {
                cell.checkLocation.image = UIImage(named: "CrossIcon")
            }
            return cell
        }
    }
    
    // Deselect row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Actions
    
    // Action performed when the unwing segue is used
    @IBAction func addLocationUnwindSegue(_ sender: UIStoryboardSegue){
        // Getting the location of the house
        if let senderVC = sender.source as? HouseMapViewController {
            self.latitude = senderVC.mapView.annotations[0].coordinate.latitude
            self.longitude = senderVC.mapView.annotations[0].coordinate.longitude
            self.checkLocation = true
        }
        // Reloading location cell
        let indexPath = IndexPath(row: cells.index(of: "LocationCell")!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // Action performed when a house is wanted to be added
    @IBAction func addHouse(_ sender: UIButton) {
        tableView.reloadData()
        // Getting the information from the cells
        let name = (tableView.dequeueReusableCell(withIdentifier: cells[0]) as! HouseNameTableViewCell).nameText.text!
        if name != "" {
            let rooms = Int((tableView.dequeueReusableCell(withIdentifier: cells[1]) as! HouseRoomsTableViewCell).roomsLabel.text!)!
            let baths = Int((tableView.dequeueReusableCell(withIdentifier: cells[2]) as! HouseBathsTableViewCell).bathsLabel.text!)!
            let rating = Int((tableView.dequeueReusableCell(withIdentifier: cells[3]) as! HouseRatingTableViewCell).ratingLabel.text!)!
            if checkLocation {
                house = House(name: name, roomsNumber: rooms, bathsNumber: baths, rating: rating, latitude: self.latitude, longitude: self.longitude)
                self.performSegue(withIdentifier: "addHouseUnwindSegue", sender: self)
            }
            else {
                Helper().showOkAlertView(self, title: "Error", message: "You need to add a location for the house")
            }
        }
        else {
            Helper().showOkAlertView(self, title: "Error", message: "You need to add a name for the house")
        }
    }
    
    
}
