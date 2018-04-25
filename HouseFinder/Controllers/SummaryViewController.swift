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
    
    let cells = ["houseCell", "transportationCell", "supermarketCell"]
    var house = House()
    var transportations:[Transportation] = []
    var supermarkets:[Supermarket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.summaryTableView.delegate = self
        self.summaryTableView.dataSource = self
        //Navigation Bar
        navigationItem.title = "Summary"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath) as! SummaryHouseTableViewCell
            
            cell.nameLabel.text = house.name
            cell.roomsLabel.text = String(house.roomsNumber)
            cell.bathsLabel.text = String(house.bathsNumber)
            cell.ratingLabel.text = String(house.rating)
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath) as! SummaryTransportationTableViewCell
            
            cell.stationLabel.text = transportations[indexPath.row].stop
            
            return cell
        }
        else {
            let cell = self.summaryTableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! SummarySupermarketTableViewCell
            
            cell.supermarketLabel.text = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].name
            cell.imageView?.image = Helper().getSupermarketsChecked(supermarkets: supermarkets)[indexPath.row].image
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150.0
        }
        else {
            return 44.0
        }
    }

}
