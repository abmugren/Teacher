//
//  SubCategoryVC.swift
//  Teachers
//
//  Created by MacBook on 11/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

protocol selectedSub: class {
    func subGategories(subName: String, subID: String)
}

class SubCategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let materialID = UserDefaults.standard.string(forKey: "materialID")
    
    var subCategories = [City]()
    var searchArray = [City]()
    
    var delegate: selectedSub!
    
    var subName = ""
    var subID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true

        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.getSubCategories(id: materialID!) { (data) in
                self.subCategories = data
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
            subCategories = searchArray
            myTableView.reloadData()
            return
        }
        subCategories = searchArray.filter({ leadInfo -> Bool in
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
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (APPLANGUAGE == "en"){
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
    @IBAction func doneBtn(_ sender: Any) {
        delegate.subGategories(subName: subName, subID: subID)
        dismiss(animated: true, completion: nil)
    }
    
}
