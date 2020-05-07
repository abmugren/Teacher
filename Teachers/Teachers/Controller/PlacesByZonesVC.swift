//
//  PlacesByZonesVC.swift
//  Indexzone
//
//  Created by MacBook on 3/8/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class PlacesByZonesVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchbar1: UITextField!
    @IBOutlet weak var searchbar2: UISearchBar!
    @IBOutlet weak var fView: UIView!
    
    @IBOutlet weak var materialTF: UITextField!
    @IBOutlet weak var subCategoryTF: UITextField!
    
    @IBOutlet weak var choosecategorytitle: UILabel!
    @IBOutlet weak var eduLevelTF: UITextField!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    var categoryID = ""
    var testID = ""
    var placeID = UserDefaults.standard.value(forKey: "zoneplace") as! String
    var titleEN = UserDefaults.standard.value(forKey: "titleEN") as? String
    var titleAR = UserDefaults.standard.value(forKey: "titleAR") as? String
    
    var userPlaces : [Places] = []
    var currentLat = UserDefaults.standard.value(forKey: "CurrentLatitude")
    var currentLang = UserDefaults.standard.value(forKey: "CurrentLonitude")
    
    
    var filteredMaterialName = ""
    var filterefMaterialID = ""
    
    var filterSubName = ""
    var filterSubID = ""
    var materialEnglish = ""
    var materialsubcategoryEn = ""
    var refreshControl : UIRefreshControl?

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        if APPLANGUAGE == "en"{
            filterLabel?.font = UIFont(name: "Cairo-Regular", size: 20.0)

        }
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            WebServices.instance.getplacebyzone(ZoneID: placeID) { (data) in
                self.userPlaces = data
                self.collectionView.reloadData()
            }

        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

        addRefreshControl()

        choosecategorytitle.text = "ccategory".localized
//        searchbar2.layer.borderWidth = 1.0
        //searchbar2.layer.borderColor = UIColor.white.cgColor
      //searchbar2.backgroundColor = UIColor.white
        
        //searchbar2.barTintColor = UIColor.white
        searchbar1.backgroundColor = UIColor.clear
        searchbar1.layer.borderWidth = 1.0
        searchbar1.layer.borderColor = UIColor.lightGray.cgColor
        
        searchbar1.backgroundColor = UIColor.clear
        
        searchbar1.textColor = UIColor.black
        searchbar1.font = UIFont(name: "Cairo-Regular", size: 18.0)
        searchbar1.backgroundColor = UIColor.white
        let textField2 = searchbar2.value(forKey: "_searchField") as? UITextField
        textField2?.textColor = UIColor.black
        textField2?.font = UIFont(name: "Cairo-Regular", size: 18.0)
        textField2?.backgroundColor = UIColor.white
        searchbar1.isUserInteractionEnabled = false
        if APPLANGUAGE == "ar"{
            searchbar1.placeholder = titleAR
        }else{
            searchbar1.placeholder = titleEN
        }
//        searchbar2.placeholder = "searchwith".localized
        textField2?.attributedPlaceholder = NSAttributedString(string: "searchwith".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])

        super.viewDidLoad()
        
        //subCategoryTF.placeholder = "sub".localized
        //materialTF.placeholder = "material".localized
        //eduLevelTF.placeholder = "eduu".localized
        filterLabel.text = "filter".localized
        
        subCategoryTF.attributedPlaceholder = NSAttributedString(string: "sub".localized, attributes: [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: "1C3C74", opacity: 1.0)])
        
        materialTF.attributedPlaceholder = NSAttributedString(string: "material".localized, attributes: [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: "1C3C74", opacity: 1.0)])
        
        eduLevelTF.attributedPlaceholder = NSAttributedString(string: "eduu".localized, attributes: [NSAttributedStringKey.foregroundColor: hexStringToUIColor(hex: "1C3C74", opacity: 1.0)])



        
    }
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(refreshApi), for: .valueChanged)
        collectionView.addSubview(refreshControl!)
    }
    @objc func refreshApi(){
        WebServices.instance.getplacebyzone(ZoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }

        refreshControl?.endRefreshing()
    }

    @IBAction func filterMaterial(_ sender: Any) {
        performSegue(withIdentifier: "mat", sender: nil)
    }
    
    @IBAction func subFilter(_ sender: Any) {
        performSegue(withIdentifier: "suby", sender: nil)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlaceCollection
        
        transform(cell:cell)
        
        let place = self.userPlaces[indexPath.row]
        
        if let urlPath = place.logoPath{
            let placePhoto = URL(string:"\(urlPath)")
            cell.logoPic.sd_setImage(with: placePhoto)
        }
        
        if (APPLANGUAGE == "en"){
            var catID = ""
            if  let categoryID = place.categoryID {
                catID = categoryID
            }
            cell.placeDescription.text = catID
        }
        else {
            var catAR = ""
            if  let categoryID = place.categoryAR {
                catAR = categoryID
            }
            cell.placeDescription.text = catAR
        }
        
        

        if let materialID = place.materialEN {
            materialEnglish = "/" + materialID
        }
        
        if let materialSub = place.SubCatEn {
            materialsubcategoryEn = "/" + materialSub
        }
        
//        cell.placeDescription.text = catID + "" + materialEnglish + "" + materialsubcategoryEn
        
//        cell.placeDescription.text = place.categoryID! + " / " + String(describing: place.materialEN!) + " / " + String(describing: place.SubCatEn!)
        cell.placeTitle.text = place.titlename!
        cell.totalfav.text = place.totalFav!
        //cell.totalrate.text = place.rate
        cell.totalView.text = place.totalwatch!
        if place.totalRate != nil{
            cell.rating.rating = place.totalRate!
        }
        // get distance
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach{transform(cell:$0)}
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = self.userPlaces[indexPath.row]
        
        UserDefaults.standard.set(place._id!, forKey: "placeID")
        print("placeID",place._id!)
        performSegue(withIdentifier: "collectionsegue", sender: nil)
    }
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //Space between items in the same row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //Size of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfCells : CGFloat = 2.0
        let paddingSpace : CGFloat = 10.0 * (numOfCells + 1.0 )
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 220)
        
    }
    func transform(cell:UICollectionViewCell){
        let coverfrmae = cell.convert(cell.bounds,to:self.view)
        let transfromOffsetY = collectionView.bounds.height * 2/3
        let parcent = getParcent(value:(coverfrmae.minY - transfromOffsetY) / (collectionView.bounds.height - transfromOffsetY))
        let maxScaleDifference: CGFloat = 0.2
        let scale = parcent * maxScaleDifference
        cell.transform = CGAffineTransform(scaleX:1-scale, y :1-scale)
    }
    func getParcent (value : CGFloat) -> CGFloat {
        let lBound : CGFloat = 0
        let uBound : CGFloat = 1
        if value < lBound {
            return lBound
        }else if value > uBound{
            return uBound
        }
        return value
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.collectionView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        WebServices.instance.filterbyname(searchText: searchText, zoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
        if searchText == ""{
            WebServices.instance.getplacebyzone(ZoneID: placeID) { (data) in
                print(self.placeID)
                self.userPlaces = data
                self.collectionView.reloadData()
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
    
    @IBAction func filter(_ sender: Any) {
        fView.isHidden = false
    }
    @IBAction func closefView(_ sender: Any) {
        fView.isHidden = true
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APPCATEGORIES.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let place = APPCATEGORIES[indexPath.row]
        if APPLANGUAGE == "ar"{
            cell.textLabel?.text = place.titleAR!
        }else{
            cell.textLabel?.text = place.titleEN!
        }
        self.categoryID = place.id!
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(APPLANGUAGE == "en"){
            eduLevelTF.text = APPCATEGORIES[indexPath.row].titleEN
        }
        else {
            eduLevelTF.text = APPCATEGORIES[indexPath.row].titleAR
        }
        
        testID = APPCATEGORIES[indexPath.row].id!
        print(testID)
        print(placeID)
        
        
                WebServices.instance.filterbycategory(categoryID: testID, zoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
        fView.isHidden = true

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as? UINavigationController
        if let dis = navController?.topViewController as? MaterialFilterVC {
            
            dis.categoryID = testID
            dis.delegate = self
        }
        if let dist = navController?.topViewController as? SubCategoryFilterVC {
            dist.materialID = filterefMaterialID
            dist.delegate = self
        }
    }
    
    
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
        self.navigationItem.title = "Search".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}


extension PlacesByZonesVC: filterMaterial {
    func filteredMaterial(filterMaterialN: String, filterMaterialIL: String) {
        filteredMaterialName = filterMaterialN
        filterefMaterialID = filterMaterialIL
        
        materialTF.text = filterMaterialN
        
        print(filterefMaterialID)
        
        
        WebServices.instance.GetFilteredMaterials(cityID: placeID, materialID: filterefMaterialID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
    }
}

extension PlacesByZonesVC: subsFilter {
    func filterSub(subCategoryN: String, subCategoryI: String) {
        filterSubName = subCategoryN
        filterSubID = subCategoryI
        
        subCategoryTF.text = filterSubName
        
        WebServices.instance.GetFilteredSubCategories(cityID: placeID, subCategoryID: filterSubID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
    }
    
    
}
