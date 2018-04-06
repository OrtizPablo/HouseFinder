//
//  MenuViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    let cells = ["HouseCell", "TransportationCell", "SupermarketCell", "SummaryCell"]

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
    // Function that adds a property to the property list
}
