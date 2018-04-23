//
//  HouseViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 4/4/18.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit
import MapKit

class HouseMapViewController: UIViewController, MKMapViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Functions
    
    func addAnnotationTest(){
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(51.500765, -0.124616)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Title"
        annotation.subtitle = "Subtitle"
        
        mapView.addAnnotation(annotation)
    }
    
    // Fuction that initializate the initial values of the view
    func initiateView(){
        // Adding a title to the toolBar
        navigationItem.title = "House Location"
        
        // Setting the initial region of the view
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let initialLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(51.500765, -0.124616) // Big Ben
        let region: MKCoordinateRegion = MKCoordinateRegionMake(initialLocation, span)
        mapView.setRegion(region, animated: true)
        
        //Adding the tap recognizer to the view
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapped(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
        //Adding the double tap recognizer to the view
        let doubleTapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(doubleTapRecognizer)
        
        tapRecognizer.require(toFail: doubleTapRecognizer)
        tapRecognizer.delaysTouchesBegan = true
        doubleTapRecognizer.delaysTouchesBegan = true
        
        self.mapView.delegate = self
    }
    
    //MARK: Actions
    
    // Function that adds an annotation to the point tapped in the mapView
    @IBAction func tapped(_ recognizer: UITapGestureRecognizer){
        // If there is an annotation in the mapView, this annotation is removed
        if mapView.annotations.count > 0 {
            mapView.removeAnnotation(mapView.annotations[0])
        }
        
        //
        let location = recognizer.location(in: self.mapView)
        let tapLocation = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = tapLocation
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            // Getting the location of the annotation and adding it to the map
            let cllocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(cllocation, completionHandler:{ (placemarks, error) -> Void in
                if let error = error {
                    print("Unable to Reverse Geocode Location (\(error))")
                    print("Unable to Find Address for Location")
                    
                } else {
                    if let placemarks = placemarks, let placemark = placemarks.first {
                        if let thoroughfare = placemark.thoroughfare{
                            annotation.title = thoroughfare
                            if let subThoroughfare = placemark.subThoroughfare{
                                annotation.title = annotation.title! + " " + subThoroughfare
                            }
                        }
                    } else {
                        print("No Matching Addresses Found")
                    }
                }
            })
            group.leave()
        }
        group.notify(queue: .main) {
            self.mapView.addAnnotation(annotation)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    // Function used when the user does a double tap in the MapView
    @IBAction func doubleTapped(_ recognizer: UITapGestureRecognizer){
        print("doubleTapped")
    }
    
    // Action that returns the location of the house
    @IBAction func addLocation(_ sender: UIButton) {
        // If there is no annotation
        if mapView.annotations.count == 0 {
            self.showOkAlertView("Error", message: "You need to add an annotation")
        }
        // If there is annotation we call the unwind segue
        else {
            self.performSegue(withIdentifier: "addLocationUnwindSegue", sender: self)
        }
    }
}

