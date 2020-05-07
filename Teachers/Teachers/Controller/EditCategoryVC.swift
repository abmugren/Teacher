//
//  EditCategoryVC.swift
//  Teachers
//
//  Created by MacBook on 11/26/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

protocol selectedCategory: class {
    func newCategory(categoryName: String, categoryID: String)
}

class EditCategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: selectedCategory!
    
    var newCategoryName = ""
    var newCategoryID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            
            guard !searchText.isEmpty else {
                APPCATEGORIES = APPCATEGORIESSTORE
                myTableView.reloadData()
                return
            }
            APPCATEGORIES = APPCATEGORIESSTORE.filter({ leadInfo -> Bool in
                
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

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APPCATEGORIES.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(APPLANGUAGE == "en"){
            cell.textLabel?.text = APPCATEGORIES[indexPath.row].titleEN
        }
        else {
            cell.textLabel?.text = APPCATEGORIES[indexPath.row].titleAR
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            newCategoryName = APPCATEGORIES[indexPath.row].titleEN!
        }
        else {
            newCategoryName = APPCATEGORIES[indexPath.row].titleAR!
        }
        
        newCategoryID = APPCATEGORIES[indexPath.row].id!
        
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtn(_ sender: Any) {
        delegate.newCategory(categoryName: newCategoryName, categoryID: newCategoryID)
        dismiss(animated: true, completion: nil)
    }
    
}
