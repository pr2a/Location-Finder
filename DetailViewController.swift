//
//  DetailViewController.swift
//  lab6
//
//  Created by Priya Ganguly on 11/10/19.
//  Copyright © 2019 idk. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController {
    //chosen TableViewCell
    var selectedPlace:place!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var searchItem: UITextField!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //enter address and get coordinates
        let geoCoder = CLGeocoder()
        
        let addressString = selectedPlace.placeName!
        CLGeocoder().geocodeAddressString(addressString, completionHandler: {(placemarks, error) in
            
            if error != nil {
                print("GeoCode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                print(location)
                
                let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = placemark.locality
                ani.subtitle = placemark.subLocality
                self.map.addAnnotation(ani)
                
                self.long.text = String(placemark.location!.coordinate.longitude)
                self.lat.text = String(placemark.location!.coordinate.latitude)
            }
        })
    }
    
    @IBAction func newPlaces(_ sender: Any) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchItem.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            
            //resets pins on the map
            let allAnnotations = self.map.annotations
            self.map.removeAnnotations(allAnnotations)
            
            for i in 1...matchingItems.count - 1 {
                let place = matchingItems[i].placemark
                
                let location = place.location
                let coords = place.coordinate
                
                let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: place.location!.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                
                self.map.addAnnotation(ani)
            }   
        }  
    }
    
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex) {
               case 0:
                   map.mapType = MKMapType.standard
               case 1:
                  map.mapType = MKMapType.satellite  
               default:
                   map.mapType = MKMapType.standard
               }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}
