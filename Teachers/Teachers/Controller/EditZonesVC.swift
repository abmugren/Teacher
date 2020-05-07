//
//  EditZonesVC.swift
//  Teachers
//
//  Created by MacBook on 11/25/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

protocol zoneSelectedDelegate: class {
    func zoneSelected(selectedZoneName: String, selectedZoneID: String)
}

class EditZonesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: zoneSelectedDelegate!
    
    
    var zoneName = ""
    var zoneID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            APPZONES = APPZONESES
            myTableView.reloadData()
            return
        }
        APPZONES = APPZONESES.filter({ leadInfo -> Bool in
            
            guard let text = searchBar.text else {return false}
            if(APPLANGUAGE == "ar"){
                return leadInfo.titleAR!.lowercased().contains(searchText.lowercased())
            }
            else {
                return leadInfo.titleEN!.lowercased().contains(searchText.lowercased())
            }
        })
        myTableView.reloadData()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
    }

    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APPZONES.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = APPZONES[indexPath.row].titleEN
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            zoneName = APPZONES[indexPath.row].titleEN!
        }
        else {
            zoneName = APPZONES[indexPath.row].titleAR!
        }
        
        zoneID = APPZONES[indexPath.row].id!
        
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
        delegate.zoneSelected(selectedZoneName: zoneName, selectedZoneID: zoneID)
        dismiss(animated: true, completion: nil)
    }
    
}
