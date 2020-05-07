//
//  HomeVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import GoogleMaps
import PKHUD
import GoogleMobileAds
class HomeVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,UISearchBarDelegate,UITableViewDelegate , UITableViewDataSource,GADBannerViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var banner: GADBannerView!
    let locationManager = CLLocationManager()
    var searchData : [SearchResult] = []
    var selectedPlace : SearchResult?
    var mapsdata : [mapplace] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.banner.isHidden = true
        banner.delegate = self
        banner.adUnitID = "ca-app-pub-4622843713943695~9340098620"
        banner.adSize = kGADAdSizeSmartBannerPortrait
        banner.rootViewController = self
        banner.load(GADRequest())
        
        self.tableView.isHidden = true
        self.tableView.isHidden = true
        searchBar.barTintColor = UIColor(hexString: "c9c9c9")
        searchBar.backgroundColor = UIColor.clear
        let textField = searchBar.value(forKey: "_searchField") as? UITextField
        textField?.textColor = UIColor.white
        textField?.font = UIFont(name: "Cairo-Regular", size: 18.0)
        textField?.backgroundColor = UIColor.clear
//        textField?.placeholder = "Search_bar_title".localized
        textField?.attributedPlaceholder = NSAttributedString(string: "Search_bar_title".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        mapView.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationItem.title = "Home".localized
        self.tableView.separatorStyle = .none
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.banner.isHidden = false

    }
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.banner.isHidden = true

    }

//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        UserDefaults.standard.set(marker.userData, forKey: "placeID")
//        performSegue(withIdentifier: "mapplace", sender: nil)
//        return true
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableSearch

        for chr in searchBar.text! {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                cell.TitleAR.text = searchData[indexPath.row].titleAr
                cell.arabicLabel.text = searchData[indexPath.row].countryArabic
            }else{
                cell.TitleAR.text = searchData[indexPath.row].titleEN
                cell.arabicLabel.text = searchData[indexPath.row].countryEnglish

            }
        }

        cell.accessoryType = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none
            selectedPlace = nil
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            let place = self.searchData[indexPath.row]
            selectedPlace = searchData[indexPath.row]
            self.searchBar.endEditing(true)
            self.tableView.isHidden = true
            self.tableView.isHidden = true
            UserDefaults.standard.set(place.id!, forKey: "zoneplace")
            if APPLANGUAGE == "en" {
                UserDefaults.standard.set(place.titleAr!, forKey: "titleEN")

            }else{
                UserDefaults.standard.set(place.titleAr!, forKey: "titleAR")
            }
            performSegue(withIdentifier: "mySegue", sender: nil)
            searchBar.text = ""
        }
    }
    func animateCell(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        let height = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: height)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }

    }
    //Fires when the user Allow/Doesn't allow the permission of getting the current location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
        }
    }
    
    //Get the user location
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let location = locations.first {
//            //Setup the map camera
//            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
//
//            UserDefaults.standard.set(location.coordinate.latitude, forKey: "CurrentLatitude")
//            UserDefaults.standard.set(location.coordinate.longitude, forKey: "CurrentLonitude")
//
//            locationManager.stopUpdatingLocation()
//        }
//
//    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.searchData = []
//            self.tableView.reloadData()
            self.animateCell()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.tableView.isHidden = true
        }
        else{
        if isConnectedToNetwork() == true {
            WebServices.instance.searchForPlaces(searchText:searchText) { (data) in
                self.searchData = data
                //            self.tableView.reloadData()
                self.animateCell()
                self.tableView.isHidden = false
            }
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        if searchBar.text == "" {
            self.view.endEditing(true)
        }else{
            self.view.endEditing(true)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCell()
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

    }
}

