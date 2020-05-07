//
//  SubCategoryFilterVC.swift
//  Teachers
//
//  Created by MacBook on 11/29/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit


protocol subsFilter: class {
    func filterSub(subCategoryN: String, subCategoryI: String)
}

class SubCategoryFilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    var subCategories = [City]()
    
    var materialID = ""
    
    var subName = ""
    var subID = ""
    
    var delegate: subsFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.getSubCategories(id: materialID) { (data) in
                self.subCategories = data
                //            self.searchArray = data
                self.myTableView.reloadData()
            }

        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }


        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(APPLANGUAGE == "en"){
            cell.textLabel?.text = subCategories[indexPath.row].titleEN
        }
        else {
            cell.textLabel?.text = subCategories[indexPath.row].titleAR
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            subName = subCategories[indexPath.row].titleEN!
        }
        else {
            subName = subCategories[indexPath.row].titleAR!
        }
        
        subID = subCategories[indexPath.row].id!
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
    @IBAction func doneBtn(_ sender: Any) {
        delegate.filterSub(subCategoryN: subName, subCategoryI: subID)
        dismiss(animated: true, completion: nil)
    }
    
    
}
