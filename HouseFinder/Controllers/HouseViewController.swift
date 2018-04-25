//
//  HouseViewController.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 10/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit
import MapKit
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath) as! HouseNameTableViewCell
            cell.nameText.text = house.name
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath) as! HouseRoomsTableViewCell
            cell.roomsLabel.text = String(house.roomsNumber)
            cell.stepper.value = Double(house.roomsNumber)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! HouseBathsTableViewCell
            cell.bathsLabel.text = String(house.bathsNumber)
            cell.stepper.value = Double(house.bathsNumber)
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath) as! HouseRatingTableViewCell
            cell.ratingLabel.text = String(house.rating)
            cell.ratingSlider.value = Float(house.rating)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! HouseLocationTableViewCell
            // If the location has been inserted
            if house.selected || checkLocation {
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
        if indexPath.row == 4 && (self.tableView.cellForRow(at: indexPath)?.isSelected)! {
            performSegue(withIdentifier: "MapSegue", sender: nil)
        }
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
                house = House(name: name, roomsNumber: rooms, bathsNumber: baths, rating: rating, selected: checkLocation, latitude: self.latitude, longitude: self.longitude)
                self.performSegue(withIdentifier: "addHouseUnwindSegue", sender: self)
            }
            else {
                self.showOkAlertView("Error", message: "You need to add a location for the house")
            }
        }
        else {
            self.showOkAlertView("Error", message: "You need to add a name for the house")
        }
    }
    
    // Passing data with the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let houseMapViewController = segue.destination as! HouseMapViewController
            if house.selected || checkLocation {
                houseMapViewController.locationChecker = true
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = latitude
                annotation.coordinate.longitude = longitude
                houseMapViewController.annotation = annotation
            }
        }
    }
}
