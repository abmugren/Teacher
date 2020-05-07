//
//  AddPlacesVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import GoogleMaps
class AddPlacesVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UITextViewDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var addzone: UITextField!
    @IBOutlet weak var adddescription: UITextField!
    @IBOutlet weak var whatsapp: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var youtube: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var addlogo: UIButton!
    @IBOutlet weak var gallary: UIButton!
    @IBOutlet weak var agreeTitle: UIButton!
    @IBOutlet weak var pic1: UIButton!
    @IBOutlet weak var pic2: UIButton!
    @IBOutlet weak var pic3: UIButton!
    @IBOutlet weak var pic4: UIButton!
    @IBOutlet weak var pic5: UIButton!
    @IBOutlet weak var pic6: UIButton!
    @IBOutlet weak var picturesstack: UIStackView!
    @IBOutlet weak var pictureslogo: UIButton!
    @IBOutlet weak var uiviewSkip: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var zonesTableView: UITableView!
    @IBOutlet weak var zonesView: UIView!
    @IBOutlet weak var searchZones: UISearchBar!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var materialTF: UITextField!
    @IBOutlet weak var desctextview: UITextView!
    @IBOutlet weak var subCategoryTF: UITextField!
    let cityName = UserDefaults.standard.value(forKey: "cityName")
    
    
    var logopath = ""
    var imagePicked = 0
    var Image_Links = [String](arrayLiteral: "","","","","","")
    var categoryID = ""
    var zoneID = ""
    var gallaryCount=0
    
    var countryID = ""
    var cityID = ""
    
    var educationLevelID = ""
    var subCategoriid = ""
    


    override func viewDidLoad() {
        desctextview.delegate = self
        desctextview.text = "desc".localized
        desctextview.textColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)

        super.viewDidLoad()
        if(APPLANGUAGE == "en"){
            name.textAlignment = .left
            desctextview.textAlignment = .left
        }
        else {
            name.textAlignment = .right
            desctextview.textAlignment = .right

        }
        
        self.picturesstack.isHidden = true
        
        agreeTitle.setTitle("agreeTitle".localized, for: .normal)
        setPickerToField(textField: category, title: "Categories")
        setPickerToField(textField: addzone, title: "Zones")
        addlogo.setTitle("logo".localized, for: .normal)
        gallary.setTitle("gallary".localized, for: .normal)
        
        category.attributedPlaceholder = NSAttributedString(string: "Category".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        name.attributedPlaceholder = NSAttributedString(string: "Name".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        addzone.attributedPlaceholder = NSAttributedString(string: "country".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        cityTF.attributedPlaceholder = NSAttributedString(string: "city".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        materialTF.attributedPlaceholder = NSAttributedString(string: "material".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        subCategoryTF.attributedPlaceholder = NSAttributedString(string: "sub".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
//        desctextview.text = "desc".localized
//        desctextview.toolbarPlaceholder = "desc".localized

        whatsapp.attributedPlaceholder = NSAttributedString(string: "whatsapp".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        facebook.attributedPlaceholder = NSAttributedString(string: "face".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        instagram.attributedPlaceholder = NSAttributedString(string: "inst".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        email.attributedPlaceholder = NSAttributedString(string: "email".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        website.attributedPlaceholder = NSAttributedString(string: "website".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        twitter.attributedPlaceholder = NSAttributedString(string: "twitter".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        youtube.attributedPlaceholder = NSAttributedString(string: "yout".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        mobileNumber.attributedPlaceholder = NSAttributedString(string: "mobile".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        mobileNumber.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        youtube.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        twitter.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        website.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        email.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        instagram.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        facebook.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        whatsapp.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        subCategoryTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        materialTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        cityTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        addzone.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        name.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        category.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        searchZones.delegate = self
        searchZones.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view.
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (desctextview.text == "desc".localized && desctextview.textColor == UIColor(hexString: "1c3c74"))
        {
            desctextview.text = ""
            desctextview.textColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        }
        desctextview.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (desctextview.text == "")
        {
            desctextview.text = "desc".localized
            desctextview.textColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        }
        desctextview.resignFirstResponder()
    }

    @IBAction func cityController(_ sender: Any) {
        performSegue(withIdentifier: "city", sender: nil)
    }
    @IBAction func materialController(_ sender: Any) {
        performSegue(withIdentifier: "material", sender: nil)
    }
    @IBAction func subCategoryController(_ sender: Any) {
        performSegue(withIdentifier: "sub", sender: nil)
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == searchZones {
            
            guard !searchText.isEmpty else {
                APPZONES = APPZONESES
                zonesTableView.reloadData()
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
            zonesTableView.reloadData()
        }
        else {
            guard !searchText.isEmpty else {
                APPCATEGORIES = APPCATEGORIESSTORE
                categoryTableView.reloadData()
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
            categoryTableView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        searchZones.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchZones.endEditing(true)
    }
    
    @IBAction func showCategory(_ sender: Any) {
        categoryView.alpha = 1
    }
    
    @IBAction func showZones(_ sender: Any) {
        zonesView.alpha = 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryTableView {
            return APPCATEGORIES.count
        }else{
            return APPZONES.count
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = categoryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if tableView == categoryTableView {
            let cell = categoryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if APPLANGUAGE == "ar"{
                cell.textLabel?.text = APPCATEGORIES[indexPath.row].titleAR
                return cell
            }else{
                cell.textLabel?.text = APPCATEGORIES[indexPath.row].titleEN
                return cell
            }
        }
        else {
            let cell = zonesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if APPLANGUAGE == "ar"{
                cell.textLabel?.text = APPZONES[indexPath.row].titleAR
                return cell
            }else{
                cell.textLabel?.text = APPZONES[indexPath.row].titleEN
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            if APPLANGUAGE == "ar"{
                category.text = APPCATEGORIES[indexPath.row].titleAR
                categoryID = APPCATEGORIES[indexPath.row].id!
                
                UserDefaults.standard.set(categoryID, forKey: "education")
                categoryView.alpha = 0
            }else{
                category.text = APPCATEGORIES[indexPath.row].titleEN
                categoryID = APPCATEGORIES[indexPath.row].id!
                
                UserDefaults.standard.set(categoryID, forKey: "education")
                
                categoryView.alpha = 0
            }
        }
        else {
            if APPLANGUAGE == "ar"{
                addzone.text = APPZONES[indexPath.row].titleAR
                zoneID = APPZONES[indexPath.row].id!
                UserDefaults.standard.set(zoneID, forKey: "COUNTRYID")
                zonesView.alpha = 0
            }else{
                addzone.text = APPZONES[indexPath.row].titleEN
                zoneID = APPZONES[indexPath.row].id!
                print(zoneID)
                    
                UserDefaults.standard.set(zoneID, forKey: "COUNTRYID")
                zonesView.alpha = 0
            }
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 45
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @IBAction func addLogo(_ sender: Any) {
        imagePicked = 1
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "Photolibrary".localized, message: "", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if imagePicked == 1{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    let messeagePhoto = URL(string:"\(urlPath)")!
                    self.logopath = path!
                    print("Message",messeagePhoto)
                    HUD.flash(.success, delay: 2.0)
                    self.pictureslogo.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 2{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic1.setImage(image, for: .normal)
                }
            }
            
            
        }else if imagePicked == 3{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[1] = urlPath
//                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic2.setImage(image, for: .normal)
                }
            }
            
            
        }
        else if imagePicked == 4{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[2] = urlPath
//                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic3.setImage(image, for: .normal)
                }
            }
            
            
        }else if imagePicked == 5{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[3] = urlPath
//                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic4.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 6{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[4] = urlPath
//                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic5.setImage(image, for: .normal)
                }
            }
        } else if imagePicked == 7{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[5] = urlPath
//                        self.Image_Links[0] = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic6.setImage(image, for: .normal)
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        HUD.show(.progress)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func exit(_ sender: Any) {
        if let tabsController = UIApplication.shared.delegate?.window??.rootViewController as? MyTabBarVC {
            tabsController.selectedIndex = 2
        }
    }
    @IBAction func pic4gallary(_ sender: Any) {
        imagePicked = 5
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    @IBAction func pic5gallary(_ sender: Any) {
        imagePicked = 6
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    @IBAction func pic6gallary(_ sender: Any) {
        imagePicked = 7
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func pic3gallary(_ sender: Any) {
        imagePicked = 4
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    @IBAction func pic1gallary(_ sender: Any) {
        imagePicked = 2
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    @IBAction func pic2gallary(_ sender: Any) {
        imagePicked = 3
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func gallary(_ sender: Any) {
        /*
         
         */
        if picturesstack.isHidden == false {
            picturesstack.isHidden = true
        }else if picturesstack.isHidden == true {
            picturesstack.isHidden = false
        }
        
    }
    @IBAction func addPlace(_ sender: Any) {
        (sender as! UIButton).shake()

        if name.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredname".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if category.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredcategory".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if addzone.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredzone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if desctextview.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouentereddescription".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if mobileNumber.text?.isEmpty  == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredmobile".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if (logopath == ""){
            AlertHandler().displayMyAlertMessage(message: "Logo Required", title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else{
            if isConnectedToNetwork() == true {
                print("Internet connection OK")

            HUD.show(.progress)
                WebServices.instance.addPlace(logoPath: logopath, img1: Image_Links[0], img2: Image_Links[1], img3: Image_Links[2], img4: Image_Links[3], img5: Image_Links[4], img6: Image_Links[5], title: name.text!, desc: desctextview.text!, face: facebook.text!, insta: instagram.text!, whatsapp: whatsapp.text!,website: website.text!, twitter: twitter.text!, youtube: youtube.text!, lang:0.0, lat: 0.0, categoryID: categoryID, zoneID: zoneID, materialID: educationLevelID , subCategoryID: subCategoriid, cityID: cityID, mobile: mobileNumber.text!, email: email.text!, completion: { (status,error) in
                    if status{
                        HUD.hide()
                        HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "YourPlaceAddedSuccessfully".localized), delay: 4.0)
                        //self.performSegue(withIdentifier: "mySegueeID", sender: nil)
                        self.name.text = ""
                        self.category.text = ""
                        self.addzone.text = ""
                        self.desctextview.text = ""
                        self.whatsapp.text = ""
                        self.facebook.text = ""
                        self.instagram.text = ""
                        self.email.text = ""
                        self.website.text = ""
                        self.twitter.text = ""
                        self.youtube.text = ""
                        self.mobileNumber.text = ""
                        self.subCategoryTF.text = ""
                        self.picturesstack.isHidden = true
                        self.pictureslogo.setImage(#imageLiteral(resourceName: "upload-folder24"), for: .normal)
                        self.pic1.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic2.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic3.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic4.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic5.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic6.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        
                    }
                    else if error == ""{
                        HUD.hide()
                        AlertHandler().displayMyAlertMessage(message: "Checkdata".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                    }
                    
                })
            } else {
                AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
            }

//            else{
//                HUD.flash(.labeledError(title: "Wrong".localized, subtitle: "PLZSelectYourplaceLOCATION".localized), delay: 4.0)
//            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {

        if UserDefaults.standard.value(forKey: "id") == nil{
            uiviewSkip.alpha = 1
            let alertController = UIAlertController(title: "Attention".localized, message: "Gotologinfirsttoallowyoutoaddplace".localized, preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "Loginnow".localized, style: UIAlertActionStyle.default) {
                UIAlertAction in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "login")
                
                self.present(controller, animated: true, completion: nil)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
        }else{
            uiviewSkip.alpha = 0
            
        }
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
        self.navigationItem.title = "AddPlace".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as? UINavigationController
        if let dis = navController?.topViewController as? citiesVC {
            
            dis.delegate = self
            
        }
        if let dis = navController?.topViewController as? EditPlaceVC {
            
        }
        
        if let material = navController?.topViewController as? MaterialsVC {
            material.delegate = self
        }
        
        if let sub = navController?.topViewController as? SubCategoryVC {
            sub.delegate = self
        }
    }
}

extension AddPlacesVC :citySelectionDelegate {
    func citySelected(selectedCityName: String, selectedCityID: String) {
        cityTF.text = selectedCityName
        cityID = selectedCityID
    }
}
extension AddPlacesVC: educationLevelSelected {
    func educationLevel(educationName: String, educationLevel: String) {
        materialTF.text = educationName
        educationLevelID = educationLevel
    }
    
    
}

extension AddPlacesVC: selectedSub {
    func subGategories(subName: String, subID: String) {
        subCategoryTF.text = subName
        subCategoriid = subID
        
        
    }
}

