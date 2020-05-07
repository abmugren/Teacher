//
//  MaterialFilterVC.swift
//  Teachers
//
//  Created by MacBook on 11/29/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

protocol filterMaterial: class {
    func filteredMaterial(filterMaterialN: String, filterMaterialIL: String)
}

class MaterialFilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var cancelOutlet: UIBarButtonItem!
    var categoryID = ""
    var materials = [City]()
    var searchArray = [City]()
    
    
    var materialName = ""
    var materialID = ""
    
    var delegate: filterMaterial!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
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
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtn(_ sender: Any) {
        delegate.filteredMaterial(filterMaterialN: materialName, filterMaterialIL: materialID)
        dismiss(animated: true, completion: nil)
    }
}
