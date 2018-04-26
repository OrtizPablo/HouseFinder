//
//  PropertiesViewController.swift
//  HouseFinder
//
//  Created by Pablo Ortiz Rodríguez on 25/04/2018.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit

class PropertiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var actionsView: UIView!
    @IBOutlet weak var propertiesTableView: UITableView!
    var properties: [String] = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        self.propertiesTableView.delegate = self
        self.propertiesTableView.dataSource = self
        
        actionsView.isHidden = true
        navigationItem.title = "Properties"
        calculateButton.layer.cornerRadius = 20
        modifyButton.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = propertiesTableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        cell.textLabel?.text = properties[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionsView.isHidden = false
    }

    @IBAction func modifyProperty(_ sender: UIButton) {
        actionsView.isHidden = true
    }
    
    @IBAction func deleteProperty(_ sender: UIButton) {
        actionsView.isHidden = true
    }
    
}
