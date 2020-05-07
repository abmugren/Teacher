//
//  MapViewVC.swift
//  Indexzone
//
//  Created by MacBook on 2/19/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import PKHUD
import MapKit

    class MapViewVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSPlacePickerViewControllerDelegate {
        @IBOutlet weak var mapView: GMSMapView!
        var long = 0.0
        var lat = 0.0
        //To handle current location
        let locationManager = CLLocationManager()
        
        var timeOther = UIDatePicker()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            mapView.delegate = self
            //setup the camera for the new view controller "Search Places View controller"
        }
        
        
        //Fires when the user Allow/Doesn't allow the permission of getting the current location
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .authorizedWhenInUse {
                
                locationManager.startUpdatingLocation()
                
                mapView.isMyLocationEnabled = true
                mapView.settings.myLocationButton = true
            }
        }
        
        //Get the user location
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if let location = locations.first {
                //Setup the map camera
                mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 17, bearing: 0, viewingAngle: 0)
                
                locationManager.stopUpdatingLocation()
                let center = self.mapView.camera.target
                //Setup the limits for fetching nearby places
                let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
                let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
                
                let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
                
                let config = GMSPlacePickerConfig(viewport: viewport)
                let placePicker = GMSPlacePickerViewController(config: config)
                placePicker.delegate = self
                
                present(placePicker, animated: true, completion: nil)
            }
            
        }
        
        
        //Fires when we press the search button
        @IBAction func pickPlace(_ sender: UIBarButtonItem) {
            
            

        }
        
        
        //Fires when the user selects a place from the list
        func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
            
            // Dismiss the place picker, as it cannot dismiss itself.
            viewController.dismiss(animated: true, completion: nil)
            
            //Get a new camera equal to the coordinates of the new selected place
            
            let newCamera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 17, bearing: 0, viewingAngle: 0)
            print(place.coordinate.latitude,place.coordinate.longitude)
            lat  = place.coordinate.latitude as Double
            long = place.coordinate.longitude as Double
            UserDefaults.standard.set(lat, forKey: "latitplace")
            UserDefaults.standard.set(long, forKey: "langitplace")
            
            //Set the map view camera to the new camera
            self.mapView.camera = newCamera
            
            //Clear all old markers, then add a new marker
            self.mapView.clear()
            let marker = GMSMarker(position: place.coordinate)
            marker.map = self.mapView
            HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "PlaceSelectedSuccessfully".localized), delay: 2.0)

            dismiss(animated: true, completion: nil)
        }
        
        
        
        func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
            // Dismiss the place picker, as it cannot dismiss itself.
            viewController.dismiss(animated: true, completion: nil)
            print("No Place Selected")
            dismiss(animated: true, completion: nil)
            
            HUD.flash(.labeledError(title: "Wrong".localized, subtitle: "Noplaceselected".localized), delay: 2.0)
        }
        

}
