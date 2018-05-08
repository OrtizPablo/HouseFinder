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
    
    let cells = ["NameCell", "RoomsCell", "BathsCell", "RatingCell", "HouseLocationCell", "JobLocationCell"]
    var checkHouseLocation = false
    var checkJobLocation = false
    
    // House properties
    var houseLatitude: CLLocationDegrees = 0
    var houseLongitude: CLLocationDegrees = 0
    var jobLatitude: CLLocationDegrees = 0
    var jobLongitude: CLLocationDegrees = 0
    var house = House()
    var job = Job()
    
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
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! HouseLocationTableViewCell
            cell.locationLabel.text = "House Location"
            // If the location has been inserted
            if house.selected || checkHouseLocation {
                cell.checkLocation.image = UIImage(named: "TicIcon")
            }
            else {
                cell.checkLocation.image = UIImage(named: "CrossIcon")
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! HouseLocationTableViewCell
            cell.locationLabel.text = "Job Location"
            // If the location has been inserted
            if job.selected || checkJobLocation {
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
        else if indexPath.row == 5 && (self.tableView.cellForRow(at: indexPath)?.isSelected)! {
            performSegue(withIdentifier: "JobMapSegue", sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Actions
    
    // Action performed when the unwing segue is used
    @IBAction func addLocationUnwindSegue(_ sender: UIStoryboardSegue){
        // Getting the location of the house
        if let senderVC = sender.source as? HouseMapViewController {
            self.houseLatitude = senderVC.mapView.annotations[0].coordinate.latitude
            self.houseLongitude = senderVC.mapView.annotations[0].coordinate.longitude
            self.checkHouseLocation = true
        }
        // Reloading location cell
        let indexPath = IndexPath(row: cells.index(of: "HouseLocationCell")!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // Action performed when the unwing segue is used
    @IBAction func addJobLocationUnwindSegue(_ sender: UIStoryboardSegue){
        // Getting the location of the house
        if let senderVC = sender.source as? HouseJobMapViewController {
            self.jobLatitude = senderVC.mapView.annotations[0].coordinate.latitude
            self.jobLongitude = senderVC.mapView.annotations[0].coordinate.longitude
            self.checkJobLocation = true
        }
        // Reloading location cell
        let indexPath = IndexPath(row: cells.index(of: "JobLocationCell")!, section: 0)
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
            if self.checkHouseLocation {
                house = House(name: name, roomsNumber: rooms, bathsNumber: baths, rating: rating, selected: checkHouseLocation, latitude: self.houseLatitude, longitude: self.houseLongitude)
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
            if house.selected || self.checkHouseLocation {
                houseMapViewController.locationChecker = true
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = houseLatitude
                annotation.coordinate.longitude = houseLongitude
                houseMapViewController.annotation = annotation
            }
        }
        if segue.identifier == "JobMapSegue" {
            let houseJobMapViewController = segue.destination as! HouseJobMapViewController
            if job.selected || self.checkJobLocation {
                houseJobMapViewController.locationChecker = true
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = jobLatitude
                annotation.coordinate.longitude = jobLongitude
                houseJobMapViewController.annotation = annotation
            }
        }
    }
}
