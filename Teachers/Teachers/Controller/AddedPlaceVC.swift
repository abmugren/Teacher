//
//  AddedPlaceVC.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import SDWebImage
import PKHUD
class AddedPlaceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var userPlaces : [Places] = []
    var refreshControl : UIRefreshControl?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        addRefreshControl()
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.getplaces{ (data) in
                self.userPlaces = data
                self.tableView.reloadData()
                if self.userPlaces.count == 0{
                    self.tableView.separatorStyle = .none
                    AlertHandler().displayMyAlertMessage(message: "TheirisNoAddedPlaces".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
                }else if self.userPlaces.count != 0{
                    self.tableView.reloadData()
                }
                print(self.userPlaces.count)
            }
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }


        // Do any additional setup after loading the view.
    }
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(refreshApi), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    @objc func refreshApi(){
        WebServices.instance.getplaces{ (data) in
            self.userPlaces = data
            self.tableView.reloadData()
            if self.userPlaces.count == 0{
                self.tableView.separatorStyle = .none
                AlertHandler().displayMyAlertMessage(message: "TheirisNoAddedPlaces".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
            }else if self.userPlaces.count != 0{
                self.tableView.reloadData()
            }
            print(self.userPlaces.count)
        }
        refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPlaces.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddedPlace
        let place = self.userPlaces[indexPath.row]
        cell.placetitle.text = place.titlename
        cell.totalratelabel.text = String(describing: Int(place.totalRate!))
        cell.totalfav.text = place.totalFav
        cell.totalrate.rating = place.totalRate!
        
        if(APPLANGUAGE == "en"){
            cell.category.text = place.categoryID
            cell.addzone.text = place.zoneID
        }
        else {
            cell.category.text = place.categoryAR
            cell.addzone.text = place.zoneAR
        }
        cell.placeID = place._id!
        if let urlPath = place.logoPath{
            let placePhoto = URL(string:"\(urlPath)")!
            cell.placelogo.sd_setImage(with: placePhoto)
        }
        if place.status == 1{
            cell.statuscolor.backgroundColor = UIColor.green
        }else if place.status == 2{
            cell.statuscolor.backgroundColor = UIColor.blue
        }else if place.status == 3{
            cell.statuscolor.backgroundColor = UIColor.red
        }else if place.status == 0{
            cell.statuscolor.backgroundColor = UIColor.yellow
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Show".localized) { (rowAction,indexPath) in
            print("",indexPath.row)
            let place = self.userPlaces[indexPath.row]
            UserDefaults.standard.set(place._id!, forKey: "placeID")
            self.performSegue(withIdentifier: "mySegueID", sender: nil)
        }
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete".localized) { (rowAction,indexPath) in
            print("",indexPath.row)
            HUD.show(.progress)
            let place = self.userPlaces[indexPath.row]
            WebServices.instance.removeuserplace(id: place._id!, completion: { (status,error ) in
                if status{
                    HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "youDeletedtheplace".localized), delay: 4.0)
                    self.userPlaces.remove(at: indexPath.row)
                    tableView.reloadData()
                }
                else if error == ""{
                }
            })
        }
        deleteButton.backgroundColor = UIColor.red
        editButton.backgroundColor = UIColor.gray
        return [editButton,deleteButton]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.userPlaces[indexPath.row]
        UserDefaults.standard.set(place._id!, forKey: "placeID")
        performSegue(withIdentifier: "mySegueID", sender: nil)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationItem.title = "ADDEDPLACE".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
}

