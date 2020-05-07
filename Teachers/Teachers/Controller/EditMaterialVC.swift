//
//  EditMaterialVC.swift
//  Teachers
//
//  Created by MacBook on 11/26/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

protocol materialSelected: class {
    func materialsSelected(materialName: String, materialID: String)
}

class EditMaterialVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var categoryID = ""
    var delegate: materialSelected!

    var materials = [City]()
    var searchArray = [City]()
    
    var materialName = ""
    var materialID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.GetMaterials(id: categoryID) { (data) in
                self.materials = data
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
            materials = searchArray
            myTableView.reloadData()
            return
        }
        materials = searchArray.filter({ leadInfo -> Bool in
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materials.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(APPLANGUAGE == "en"){
            cell.textLabel?.text = materials[indexPath.row].titleEN
        }
        else {
            cell.textLabel?.text = materials[indexPath.row].titleAR
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            materialName = materials[indexPath.row].titleEN!
        }
        else {
            materialName = materials[indexPath.row].titleAR!
        }
        
        materialID = materials[indexPath.row].id!
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissBtn (_ sender: Any) {
        delegate.materialsSelected(materialName: materialName, materialID: materialID)
        dismiss(animated: true, completion: nil)
    }
}
