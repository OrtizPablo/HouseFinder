//
//  RoutesViewController.swift
//  HouseFinder
//
//  Created by Ibermatica on 8/5/18.
//  Copyright © 2018 Pablo Ortiz Rodríguez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class RoutesViewController: UIViewController, MKMapViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    var house = House()
    var job = Job()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Routes"
        self.mapView.delegate = self
        self.getRoute("walking", houseLatitude: String(house.latitude), houseLongitude: String(house.longitude), jobLatitude: String(job.latitude), jobLongitude: String(job.longitude))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Functions
    
    func getRoute(_ mode: String, houseLatitude: String, houseLongitude: String, jobLatitude: String, jobLongitude: String){
        
        var latitudes: [CLLocationDegrees] = []
        var longitudes: [CLLocationDegrees] = []
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + houseLatitude + "," + houseLongitude + "&destination=" + jobLatitude + "," + jobLongitude + "&mode=" + mode + "&key=AIzaSyA1eawVsvrTaH6ZieZHhUuSFgd7MFnyf2w"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                if let resData = json["routes"].array {
                    if let legs = resData[0]["legs"].array {
                        //Get start location
                        if let startLocation = legs[0]["start_location"].dictionary {
                            latitudes.append(CLLocationDegrees((startLocation["lat"]?.doubleValue)!))
                            longitudes.append(CLLocationDegrees((startLocation["lng"]?.doubleValue)!))
                        }
                        //Get steps
                        if let steps = legs[0]["steps"].array {
                            for step in steps {
                                latitudes.append(CLLocationDegrees(step["end_location"]["lat"].doubleValue))
                                longitudes.append(CLLocationDegrees(step["end_location"]["lng"].doubleValue))
                            }
                        }
                    }
                }
            }
            for index in 1 ..< latitudes.count {
                print("Latitude: \(latitudes[index]) - Longitude: \(longitudes[index])")
                self.drawRoute(mode, sourceLatitude: latitudes[index-1], sourceLongitude: longitudes[index-1], destinationLatitude: latitudes[index], destinationLongitude: longitudes[index])
            }
        }
    }
    
    func drawRoute(_ mode: String, sourceLatitude: CLLocationDegrees, sourceLongitude: CLLocationDegrees, destinationLatitude: CLLocationDegrees, destinationLongitude: CLLocationDegrees){
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude), addressDictionary: nil))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude), addressDictionary: nil))
        switch mode {
        case "walking":
            directionRequest.transportType = .walking
            break
        case "driving":
            directionRequest.transportType = .automobile
            break
        case "transit":
            directionRequest.transportType = .transit
            break
        default:
            directionRequest.transportType = .walking
        }
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }

}
