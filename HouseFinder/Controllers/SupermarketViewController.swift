//
//  SupermarketViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit

class SupermarketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    var supermarkets: [Supermarket] = []
    let cellImages = ["tescoIcon", "sainsburysIcon", "aldiIcon", "asdaIcon", "lidlIcon", "waitroseIcon", "othersIcon"]
    @IBOutlet weak var supermarketTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TableView
        self.supermarketTableView.delegate = self
        self.supermarketTableView.dataSource = self
        //Navigation Bar
        navigationItem.title = "Supermarket"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TableView delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarkets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = supermarketTableView.dequeueReusableCell(withIdentifier: "SupermarketInfoCell", for: indexPath) as! SupermarketTableViewCell
        cell.supermarketImageView.image = UIImage(named: cellImages[indexPath.row])
        cell.supermarketLabel.text = supermarkets[indexPath.row].name
        cell.supermarketSwitch.isOn = supermarkets[indexPath.row].check
        return cell
    }
    
    //MARK: Actions
    
    @IBAction func addSupermarkets(_ sender: UIButton) {
        getSupermarkets()
        self.performSegue(withIdentifier: "addSupermarketUnwindSegue", sender: nil)
    }
    
    //Function that adds all the supermarkets checked in the tableView
    func getSupermarkets(){
        var cell: SupermarketTableViewCell
        var indexPath: IndexPath
        var markets: [Supermarket] = []
        for index in 0..<supermarkets.count {
            indexPath = IndexPath(row: index, section: 0)
            cell = supermarketTableView.cellForRow(at: indexPath) as! SupermarketTableViewCell
            markets.append(Supermarket(name: cell.supermarketLabel.text!, check: cell.supermarketSwitch.isOn))
        }
        self.supermarkets.removeAll()
        self.supermarkets = markets
    }
    
}
