//
//  citiesVC.swift
//  Teachers
//
//  Created by MacBook on 11/20/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit


protocol citySelectionDelegate: class {
    func citySelected(selectedCityName: String, selectedCityID: String)
}



class citiesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let countryID = UserDefaults.standard.string(forKey: "COUNTRYID")
    
    var cityName = ""
    
    var myArray = [City]()
    var searchArray = [City]()
    
    var selectedIndex = -1
    
    var checked: Bool!
    
    var delegate: citySelectionDelegate!
    
    var selectedItem: String!
    
    var selectedCity = ""
    var selectedCityID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.GetCities(id: countryID!) { (data) in
                self.myArray = data
                self.searchArray = data
                self.myTableView.reloadData()
            }

        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            myArray = searchArray
            myTableView.reloadData()
            return
        }
        myArray = searchArray.filter({ leadInfo -> Bool in
            guard let text = searchBar.text else {return false}
            if(APPLANGUAGE == "en"){
                return leadInfo.titleEN!.lowercased().contains(searchText.lowercased())
            }
            else {
                return leadInfo.titleAR!.lowercased().contains(searchText.lowercased())
            }
            
        })
        myTableView.reloadData()
    }
    
    @IBAction func dismissCities(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if (APPLANGUAGE == "en"){
            cell.textLabel?.text = myArray[indexPath.row].titleEN
        }
        else {
            cell.textLabel?.text = myArray[indexPath.row].titleAR
        }
        
        
        if indexPath.row ==  selectedIndex{
            cell.accessoryType = .checkmark
        } else  {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            selectedCity = myArray[indexPath.row].titleEN!
        }
        else {
            selectedCity = myArray[indexPath.row].titleAR!
        }
        
        selectedCityID = myArray[indexPath.row].id!
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        delegate.citySelected(selectedCityName: selectedCity, selectedCityID: selectedCityID)
        dismiss(animated: true, completion: nil)
    }
    
    
}
