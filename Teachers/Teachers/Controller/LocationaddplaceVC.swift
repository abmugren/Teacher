//
//  LocationaddplaceVC.swift
//  Indexzone
//
//  Created by MacBook on 4/5/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationaddplaceVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let lat = 0.0
    let lang = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
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
        let camera = GMSCameraPosition.camera(withLatitude: (lat), longitude: (lang), zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lang)
        marker.map = mapView
        mapView.selectedMarker = marker
        //Finally stop updating location otherwise it will come again and again in this delegate
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(UserDefaults.standard.value(forKey: "id")!)
        print(lat)
        print(lang)
        
        self.navigationItem.setHidesBackButton(true, animated:true)
 self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
    }
    
}



