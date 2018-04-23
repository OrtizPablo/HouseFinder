//
//  TransportationViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit

class TransportationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    //Transportation
    var userStops: [Transportation] = []
    let tubeLines = ["Bakerloo", "Central", "Circle", "District", "Hammersmith & City", "Jubilee", "Metropolitan", "Nothern", "Piccadilly", "Victoria", "Waterloo & City"/*, "London Overground", "Tfl Rail", "DLR", "Tram"*/]
    let tubeColors = [UIColor(red: 203/255, green: 107/255, blue: 84/255, alpha: 1),
                      UIColor(red: 218/255, green: 79/255, blue: 79/255, alpha: 1),
                      UIColor(red: 239/255, green: 244/255, blue: 77/255, alpha: 1),
                      UIColor(red: 88/255, green: 244/255, blue: 77/255, alpha: 1),
                      UIColor(red: 244/255, green: 77/255, blue: 163/255, alpha: 1),
                      UIColor(red: 155/255, green: 172/255, blue: 173/255, alpha: 1),
                      UIColor(red: 208/255, green: 77/255, blue: 244/255, alpha: 1),
                      UIColor(red: 78/255, green: 84/255, blue: 84/255, alpha: 1),
                      UIColor(red: 77/255, green: 114/255, blue: 244/255, alpha: 1),
                      UIColor(red: 77/255, green: 174/255, blue: 244/255, alpha: 1),
                      UIColor(red: 77/255, green: 244/255, blue: 234/255, alpha: 1)]

    let tubeStops = [
    //Line: Bakerloo
    ["Elephant & Castle", "Lambeth North", "Waterloo", "Embankment", "Charing Cross", "Piccadilly Circus", "Oxford Circus", "Regent's Park", "Baker Street", "Marylebone", "Edgware Road", "Paddington", "Warwick Avenue", "Maida Vale", "Kilburn Park", "Queen's Park", "Kensal Green", "Willesden Junction", "Harlesden", "Stonebridge Park", "Wembley Central", "North Wembley", "South Kenton", "Kenton", "Harrow & Wealdstone"],
    //Line: Central
    ["Epping", "Theydon Bois", "Debden", "Loughton", "Buckhurst Hill", "Grange Hill", "Chigwell", "Roding Valley", "Woodford", "South Woodford", "Snaresbrook", "Hainault", "Fairlop", "Barkingside", "Newbury Park", "Gants Hill", "Redbridge", "Wanstead", "Leytonstone", "Leyton", "Stratford", "Mile End", "Bethnal Green", "Liverpool Street", "Bank", "St.Paul's", "Chancery Lane", "Holborn", "Tottenham Court Road", "Oxford Circus", "Bond Street", "Marble Arch", "Lancaster Gate", "Queensway", "Notting Hill Gate", "Holland Park", "Shepherd's Bush", "White City", "East Acton", "North Acton", "West Acton", "Ealing Broadway", "Hanger Lane", "Perivale", "Greenford", "Northolt", "South Ruislip", "Ruislip Gardens", "West Ruislip"],
    //Line: Circle
    ["Tower Hill", "Aldgate", "Liverpool Street", "Moorgate", "Barbican", "Farringdon", "King's Cross", "Euston Square", "Great Portland Street", "Baker Street", "Edgware Road", "Paddington", "Bayswater", "Notting Hill Gate", "High Street Kensington", "Gloucester Road", "South Kensington", "Sloane Square", "Victoria", "St.James's Park", "Westminster", "Embankment", "Temple", "Blackfriars", "Mansion House", "Cannon Street", "Monument"],
    //Line: District
    ["Upminster", "Upminster Bridge", "Hornchurch", "Elm Park", "Dagenham East", "Dagenham Heathway", "Becontree", "Upney", "Barking", "East Ham", "Upton Park", "Plaistow", "West Ham", "Bromley-by-Bow", "Bow Road", "Mile End", "Stepney Green", "Whitechapel", "Aldgate East", "Tower Hill", "Monument", "Cannon Street", "Mansion House", "Blackfriars", "Temple", "Embankment", "Westminster", "St. James's Park", "Victoria", "Sloane Square", "South Kensington", "Gloucester Road", "High Street Ken.", "Earl's Court", "West Brompton", "Fulham Broadway", "Parsons Green", "Putney Bridge", "East Putney", "Southfields", "Wimbledon Park", "Wimbledon", "West Kensington", "Barons Court", "Hammersmith", "Ravenscourt Park", "Stamford Brook", "Turnham Green", "Gunnersbury", "Kew Gardens", "Richmond", "Chiswick Park", "Acton Town", "Ealing Common", "Ealing Broadway"],
    //Line: Hammersmith & City
    ["Hammersmith", "Goldhawk Road", "Shepherd's Bush", "Latimer Road", "Ladbroke Grove", "Westbourne Park", "Royal Oak", "Paddington", "Edgware Road", "Baker Street", "Great Portland Street", "Euston Square", "King's Cross", "Farringdon", "Barbican", "Moorgate", "Liverpool Street", "Aldgate", "Tower Hill", "Aldgate East", "Whitechapel"],
    //Line: Jubilee
    ["Stanmore", "Canons Park", "Queensbury", "Kingsbury", "Wembley Park", "Neasden", "Dollis Hill", "Willesden Green", "Kilburn", "West Hampstead", "Finchley Road", "Swiss Cottage", "St.John's Wood", "Baker Street", "Bond Street", "Green Park", "Westminister", "Waterloo", "Southwark", "London Bridge", "Bermondsy", "Canada Water", "Canary Wharf", "Canning Town", "West Ham", "Stratford"],
    //Line: Metropolitan
    ["Aldgate", "Liverpool Street", "Moorgate", "Barbican", "Farringdon", "King's Cross", "Euston Square", "Great Portland Street", "Baker Street", "Finchley Road", "Wembley Park", "Preston Road", "Northwick Park", "Marylebone", "Harrow-on-the-hill", "West Harrow", "Rayners Lane", "Eastcote", "Ruislip Manor", "Ruislip", "Ickenham", "Hillingdon", "Uxbridge", "North Harrow", "Pinner", "Northwood Hills", "Northwood", "Moor Park", "Croxley", "Watford", "Rickmansworth", "Chorleywood", "Chalfont Latimer", "Chesham", "Amersham"],
    //Line: Northen
    ["Morden", "South Wimbledon", "Colliers Wood", "Tooting Broadway", "Tooting Bec", "Balham", "Clapham South", "Clapham Common", "Clapham North", "Stockwell", "Oval", "Kennington", "Elephant Castle", "Borough", "London Bridge", "Bank", "Moorgate", "Old Street", "Angel", "King's Cross", "Waterloo", "Embankment", "Charing Cross", "Leicester Square", "Tottenham Court Road", "Goodge Street", "Warren Street", "Euston", "Mornington Crescent", "Camden town", "Kentish Town", "Tufnell Park", "Archway", "Highgate", "East Finchley", "Finchley Central", "Mill Hill East", "West Finchley", "Woodside Park", "Totteridge", "Hiigh Barnet", "Chalk Farm", "Belsize Park", "Hampstead", "Golders Green", "Brent Cross", "Hendon Central", "Colindale", "Burnt Oak", "Edgeware"],
    //Line: Picadilly
    ["Cockfosters", "Oakwood", "Southgate", "Arnos Grove", "Bounds Green", "Wood Green", "Turnpike Lane", "Manor House", "Finsbury Park", "Arsenal", "Holloway Road", "Caledonian Road", "King's Cross", "Russell Square", "Holborn", "Covent Garden", "Leicester Square", "Piccadilly Circus", "Green Park", "Hyde Park Corner", "Knightsbridge", "South Kensington", "Gloucester Road", "Earl's Court", "Barons Court", "Hammersmith", "Acton Town", "South Ealing", "Northfields", "Boston Manor", "Osterley", "Hounslow East", "Hounslow Central", "Hounslow West", "Hatton Cross", "Heathrow Terminal 4", "Heathrow Terminals 1, 2, 3", "Ealing Common", "North Ealing", "Park Royal", "Alperton", "Sudbury Town", "Sudbury Hill", "South Harrow", "Rayners Lane"],
    //Line: Victoria
    ["Brixton", "Stockwell", "Vauxhall", "Pimlico", "Victoria", "Green Park", "Oxford Circus", "Warren Street", "Euston", "King's Cross", "Highbury & Islington", "Finsbury Park", "Seven Sisters", "Tottenham Hale", "Blackhorse Road", "Walthamstow Central"],
    //Line: Waterloo & City
    ["Waterloo", "Bank"]]
    
    @IBOutlet weak var tubePickerView: UIPickerView!
    @IBOutlet weak var stopsTableView: UITableView!
    
    //Pop Up
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //PickerView
        tubePickerView.delegate = self
        tubePickerView.dataSource = self
        //TableView
        stopsTableView.delegate = self
        stopsTableView.dataSource = self
        //Pop Up
        self.popUpView.isHidden = true
        //Navigation Bar
        navigationItem.title = "Transportation"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: PickerView delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tubeLines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = tubeLines[row]
        pickerLabel.textAlignment = .center
        pickerLabel.backgroundColor = tubeColors[row]
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stopsTableView.reloadData()
    }
    
    //MARK: TableView delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tubeStops[tubePickerView.selectedRow(inComponent: 0)].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tubeStopCell", for: indexPath) as! TransportationTableViewCell
        cell.tubeLabel.text = tubeStops[tubePickerView.selectedRow(inComponent: 0)][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.stopsTableView.deselectRow(at: indexPath, animated: true)
        let cell = stopsTableView.cellForRow(at: indexPath) as! TransportationTableViewCell
        if let stop = cell.tubeLabel.text {
            if addStation(line: tubeLines[tubePickerView.selectedRow(inComponent: 0)], stop: stop) {
                activateTimer(message: stop, color: tubeColors[tubePickerView.selectedRow(inComponent: 0)])
            }
        }
    }
    
    //MARK: Actions
    
    //Action performed when the user press the button: Add Station
    @IBAction func addStation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addStationUnwindSegue", sender: self)
    }
    
    //Action that hides the popUpView
    @IBAction func showPopUp(){
        self.popUpView.isHidden = true
    }
    
    //MARK: Functions
    
    //Function that activates the popUpView
    func activateTimer(message: String, color: UIColor){
        self.popUpView.backgroundColor = color
        self.popUpView.isHidden = false
        self.popUpLabel.text = message + " was added"
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showPopUp), userInfo: nil, repeats: false)
    }
    
    //Function that add a station
    func addStation(line: String, stop: String) -> Bool {
        for transportation in userStops {
            // If the stop was added
            if transportation.stop == stop {
                self.showOkAlertView("Error", message: "Stop " + stop + " was added")
                return false
            }
        }
        userStops.append(Transportation(line: line, stop: stop))
        return true
    }
    
}
