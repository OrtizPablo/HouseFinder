//
//  SummaryViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var summaryTableView: UITableView!
    
    let cells = ["houseCell", "jobCell", "transportationCell", "supermarketCell"]
    var house = House()
    var job = Job()
    var transportations:[Transportation] = []
    var supermarkets:[Supermarket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.summaryTableView.delegate = self
        self.summaryTableView.dataSource = self
        //Navigation Bar
        navigationItem.title = "Summary"
        summaryTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if job.selected {
            return cells.count
        }
        else {
            return cells.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the location for the job has been added
        if job.selected {
            if section == 0 {
                return 1
            }
            else if section == 1 {
                return 1
            }
            else if section == 2 {
                return transportations.count
            }
            else {
                // Only the supermarkets checked
                return Helper().getSupermarketsChecked(supermarkets: supermarkets).count
            }
        }
        else {
            if section == 0 {
                return 1
            }
            else if section == 1 {
                return transportations.count
            }
            else {
                // Only the supermarkets checked
                return Helper().getSupermarketsChecked(supermarkets: supermarkets).count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if job.selected {
            if indexPath.section == 0 {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath) as! SummaryHouseTableViewCell
                
                cell.nameLabel.text = house.name
                cell.roomsLabel.text = String(house.roomsNumber)
                cell.bathsLabel.text = String(house.bathsNumber)
                cell.ratingLabel.text = String(house.rating)
                
                return cell
            }
            else if indexPath.section == 1 {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath)
                cell.textLabel?.text = "Route"
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            else if indexPath.section == 2 {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! SummaryTransportationTableViewCell
                
                cell.stationLabel.text = transportations[indexPath.row].stop
                
                return cell
            }
            else {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath) as! SummarySupermarketTableViewCell
                
                cell.supermarketLabel.text = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].name
                cell.imageView?.image = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].image
                
                return cell
            }
        }
        else {
            if indexPath.section == 0 {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath) as! SummaryHouseTableViewCell
                
                cell.nameLabel.text = house.name
                cell.roomsLabel.text = String(house.roomsNumber)
                cell.bathsLabel.text = String(house.bathsNumber)
                cell.ratingLabel.text = String(house.rating)
                
                return cell
            }
            else if indexPath.section == 1 {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! SummaryTransportationTableViewCell
                
                cell.stationLabel.text = transportations[indexPath.row].stop
                
                return cell
            }
            else {
                let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath) as! SummarySupermarketTableViewCell
                cell.supermarketLabel.text = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].name
                cell.imageView?.image = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].image
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if job.selected {
            if section == 0 {
                return "House"
            }
            if section == 1 {
                return "Job"
            }
            else if section == 2 {
                return "Transportation"
            }
            else {
                return "Supermarkets"
            }
        }
        else {
            if section == 0 {
                return "House"
            }
            else if section == 1 {
                return "Transportation"
            }
            else {
                return "Supermarkets"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150.0
        }
        else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if job.selected {
            if indexPath.section == 1 {
                if indexPath.row == 0 && (self.summaryTableView.cellForRow(at: indexPath)?.isSelected)! {
                        self.performSegue(withIdentifier: "routesSegue", sender: nil)
                }
            }
        }
        self.summaryTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "routesSegue" {
            let routesVC = segue.destination as! RoutesViewController
            routesVC.house = self.house
        }
    }

}
