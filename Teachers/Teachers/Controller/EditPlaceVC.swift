//
//  EditPlaceVC.swift
//  Indexzone
//
//  Created by MacBook on 3/20/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import SwiftyJSON
import GoogleMaps
import SDWebImage


class EditPlaceVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var zonename: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var materialTF: UITextField!
    @IBOutlet weak var subCategoryTF: UITextField!
    @IBOutlet weak var descrip: UITextView!
    @IBOutlet weak var gallafrytitle: UIButton!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var youtube: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var whatsapp: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var instgram: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var addlogo: UIButton!
    @IBOutlet weak var agreeTitle: UIButton!
    @IBOutlet weak var exittitle: UIButton!
    @IBOutlet weak var pic1: UIButton!
    @IBOutlet weak var pic2: UIButton!
    @IBOutlet weak var pic3: UIButton!
    @IBOutlet weak var pic4: UIButton!
    @IBOutlet weak var pic5: UIButton!
    @IBOutlet weak var pic6: UIButton!
    @IBOutlet weak var picturesstack: UIStackView!
    @IBOutlet weak var pictureslogo: UIButton!
    
    var logopath: String!
    var imagePicked = 0
    var Image_Links = [String](arrayLiteral: "","","","","","")
    var categoryID: String!
    var zoneID: String!
    var cityID: String!
    var gallaryCount = 0
    var latitude = 0.0
    var longitiude = 0.0
    var placelogo: String!
    var img1: String!
    var img2: String!
    var img3: String!
    var img4: String!
    var img5: String!
    var img6: String!

    var zoneName = ""
    var newZoneID: String!
    
    var newCityName = ""
    var newCityID: String!
    
    var newCategoryName = ""
    var newCategoryID: String!
    
    var newMaterialName = ""
    var newMaterialID: String!
    
    var newSubName = ""
    var newSubID: String!
    
    
    var placeID = UserDefaults.standard.value(forKey: "placeID") as! String
    let url = APIKeys().GET_PLACE_ID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picturesstack.isHidden = true
        addlogo.setTitle("logo".localized, for: .normal)
        gallafrytitle.setTitle("gallary".localized, for: .normal)

        descrip.delegate = self as? UITextViewDelegate

        agreeTitle.setTitle("EditTitle".localized, for: .normal)
        exittitle.setTitle("Cancel".localized, for: .normal)
        category.attributedPlaceholder = NSAttributedString(string: "Category".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        name.attributedPlaceholder = NSAttributedString(string: "Name".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        zonename.attributedPlaceholder = NSAttributedString(string: "country".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        cityTF.attributedPlaceholder = NSAttributedString(string: "city".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        materialTF.attributedPlaceholder = NSAttributedString(string: "material".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        subCategoryTF.attributedPlaceholder = NSAttributedString(string: "sub".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        
        whatsapp.attributedPlaceholder = NSAttributedString(string: "whatsapp".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        facebook.attributedPlaceholder = NSAttributedString(string: "face".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        instgram.attributedPlaceholder = NSAttributedString(string: "inst".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        email.attributedPlaceholder = NSAttributedString(string: "email".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        website.attributedPlaceholder = NSAttributedString(string: "website".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        twitter.attributedPlaceholder = NSAttributedString(string: "twitter".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        youtube.attributedPlaceholder = NSAttributedString(string: "yout".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        mobile.attributedPlaceholder = NSAttributedString(string: "mobile".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        mobile.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        youtube.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        twitter.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        website.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        email.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        instgram.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        facebook.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        whatsapp.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        subCategoryTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        materialTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        cityTF.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        zonename.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        name.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        category.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        
        if isConnectedToNetwork() == true {
            print("Internet connection OK")

        HUD.show(.progress)
        Alamofire.request("\(url)?id=\(placeID)", method: .get , encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                HUD.hide()
                
                var json = JSON(value)
                print(json)
                if let category  = json["categoryID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.category.text = category["titleAr"]?.string
                    }else{
                        self.category.text = category["titleEN"]?.string
                    }
                    self.newCategoryID = (category["_id"]?.string)!
                }
                if let zone  = json["zoneID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.zonename.text = zone["titleAr"]?.string
                    }else{
                        self.zonename.text = zone["titleEN"]?.string
                    }
                    self.newZoneID = (zone["_id"]?.string)!
                }
                
                if let city  = json["cityID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.cityTF.text = city["titleAr"]?.string
                    }else{
                        self.cityTF.text = city["titleEN"]?.string
                    }
                    self.newCityID = (city["_id"]?.string)!
                }
                
                if let material  = json["materialID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.materialTF.text = material["titleAr"]?.string
                    }else{
                        self.materialTF.text = material["titleEN"]?.string
                    }
                    self.newMaterialID = (material["_id"]?.string)!

                }
                
                if let sub  = json["subCategoryID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.subCategoryTF.text = sub["titleAr"]?.string
                    }else{
                        self.subCategoryTF.text = sub["titleEN"]?.string
                    }
                    self.newSubID = (sub["_id"]?.string)!

                }
                
                if let urlPath = json["logo"].string{
                    if urlPath != "" {

                    self.logopath = urlPath
                    let placePhoto = URL(string:"\(urlPath)")!
                    self.pictureslogo.sd_setImage(with: placePhoto, for: .normal)
                    }
                }
                if let urlPath = json["img1"].string{
                    if urlPath != "" {
                    self.img1 = urlPath
                    let img1string = URL(string:"\(urlPath)")!
                    self.pic1.sd_setImage(with: img1string, for: .normal)
                    }
                }
                if let urlPath = json["img2"].string{
                    if urlPath != "" {
                        self.img2 = urlPath
                        let img1string = URL(string:"\(urlPath)")!
                        self.pic2.sd_setImage(with: img1string, for: .normal)

                    }else{
                        self.img2 = ""

                    }
                }
                if let urlPath = json["img3"].string{
                    if urlPath != "" {
                    self.img3 = urlPath
                    if urlPath != ""{
                        let img1string = URL(string:"\(urlPath)")!
                        self.pic3.sd_setImage(with: img1string, for: .normal)

                    }
                    }else{
                        self.img3 = ""
                        
                    }

                }
                if let urlPath = json["img4"].string{
                    if urlPath != "" {
                    self.img4 = urlPath
                    if urlPath != ""{
                        let img1string = URL(string:"\(urlPath)")!
                        self.pic4.sd_setImage(with: img1string, for: .normal)
                    }
                    }else{
                        self.img4 = ""
                        
                    }

                }
                if let urlPath = json["img5"].string{
                    if urlPath != "" {
                    self.img5 = urlPath
                    if urlPath != "" {
                        let img1string = URL(string:"\(urlPath)")!
                        self.pic5.sd_setImage(with: img1string, for: .normal)
                        }
                    }else{
                        self.img5 = ""
                        
                    }

                }
                if let urlPath = json["img6"].string{
                    if urlPath != "" {
                    self.img6 = urlPath
                    if urlPath != "" {
                        let img1string = URL(string:"\(urlPath)")!
                        self.pic6.sd_setImage(with: img1string, for: .normal)
                        }
                    }else{
                        self.img6 = ""
                        
                    }

                }
                self.placelogo = json["logo"].string!
                self.facebook.text! = json["face"].string!
                self.instgram.text! = json["insta"].string!
                self.website.text! = json["website"].string!
                self.whatsapp.text! = json["whats"].string!
                self.email.text! = json["email"].string!
                let email = json["email"].string!
                UserDefaults.standard.set(email, forKey: "savedEmail")
                self.descrip.text! = json["description"].string!
                self.mobile.text! = json["mobile"].string!
                let mobile = json["mobile"].string!
                UserDefaults.standard.set(mobile, forKey: "savedMobile")
                self.twitter.text! = json["twit"].string!
                self.name.text! = json["title"].stringValue
                self.cityTF.attributedPlaceholder = NSAttributedString(string: "city".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
                self.materialTF.attributedPlaceholder = NSAttributedString(string: "material".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
                
                self.subCategoryTF.attributedPlaceholder = NSAttributedString(string: "sub".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
            case .failure(let error):
                print(error)
                HUD.hide()
            }
        }
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

    }
    @IBAction func showCities(_ sender: Any) {
        //        performSegue(withIdentifier: "cities", sender: nil)
    }
    @IBAction func editZonesVC(_ sender: Any) {
        performSegue(withIdentifier: "editZones", sender: nil)
    }
    
    @IBAction func editCityVC(_ sender: Any) {
        performSegue(withIdentifier: "editCities", sender: nil)
    }
    @IBAction func editCategory(_ sender: Any) {
        performSegue(withIdentifier: "editCategory", sender: nil)
    }
    @IBAction func editMaterialVC(_ sender: Any) {
        performSegue(withIdentifier: "editMaterial", sender: nil)
    }
    @IBAction func subCategoryyVC(_ sender: Any) {
        performSegue(withIdentifier: "subs", sender: nil)
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
                        self.img1 = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    HUD.flash(.success, delay: 2.0)
                    self.pic1.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 3{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[1] = urlPath
                        self.img2 = urlPath
                        
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
                        self.img3 = urlPath
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
                        self.img4 = urlPath
                        
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
                        self.img5 = urlPath
                        
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
                        self.img6 = urlPath
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
        if picturesstack.isHidden == false {
            picturesstack.isHidden = true
        }else if picturesstack.isHidden == true {
            picturesstack.isHidden = false
        }
    }
    @IBAction func editbtn(_ sender: Any) {
        HUD.show(.progress)
        if name.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredname".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if category.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredcategory".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if zonename.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredzone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if descrip.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouentereddescription".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if mobile.text?.isEmpty  == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredmobile".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if (mobile.text == UserDefaults.standard.value(forKey: "savedMobile") as? String){
            print("edited")
            
                WebServices.instance.editPlaceNoMobile(logoPath: logopath!, img1: img1!, img2: img2 ?? "", img3: img3 ?? "", img4: img4 ?? "", img5: img5 ?? "", img6: img6 ?? "", title: name.text!, desc: descrip.text!, face: facebook.text!, insta: instgram.text!, whatsapp: whatsapp.text!,website: website.text!, twitter: twitter.text!, youtube: youtube.text!,categoryID: newCategoryID, zoneID: newZoneID, email: email.text!, id: placeID, materialID: newMaterialID!, subCategoryID: newSubID!, cityID: newCityID, completion: { (status,error) in
                    if status{
                        HUD.hide()
                        HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "YOURPLACEEDITED".localized), delay: 4.0)
                    }
                    else if error == ""{
                        HUD.hide()
                        AlertHandler().displayMyAlertMessage(message: "Checkdata".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                    }
                })
        }
        else if (email.text == UserDefaults.standard.value(forKey: "savedEmail") as? String){
            let latitude = self.latitude
            let longitude = self.longitiude
            WebServices.instance.editPlaceNoEmail(logoPath: logopath, img1: img1, img2: img2, img3: img3, img4: img4, img5: img5, img6: img6, title: name.text!, desc: descrip.text!, face: facebook.text!, insta: instgram.text!, whatsapp: whatsapp.text!,website: website.text!, twitter: twitter.text!, youtube: youtube.text!, lang:longitude, lat: latitude, categoryID: newCategoryID, zoneID: newZoneID, mobile: mobile.text!, id: placeID, materialID: newMaterialID, subCategoryID: newSubID, cityID: newCityID, completion: { (status,error) in
                if status{
                    HUD.hide()
                    HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "YOURPLACEEDITED".localized), delay: 4.0)
                }
                else if error == ""{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Checkdata".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        }
        else {
            let latitude = self.latitude
            let longitude = self.longitiude
            WebServices.instance.editPlace(logoPath: logopath, img1: img1, img2: img2, img3: img3, img4: img4, img5: img5, img6: img6, title: name.text!, desc: descrip.text!, face: facebook.text!, insta: instgram.text!, whatsapp: whatsapp.text!,website: website.text!, twitter: twitter.text!, youtube: youtube.text!, lang:longitude, lat: latitude, categoryID: newCategoryID, zoneID: newZoneID, mobile: mobile.text!, email: email.text!, id: placeID, materialID: newMaterialID, subCategoryID: newSubID, cityID: newCityID, completion: { (status,error) in
                if status{
                    HUD.hide()
                    HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "YOURPLACEEDITED".localized), delay: 4.0)
                }
                else if error == ""{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Checkdata".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        }
    }
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationItem.title = "EditTitle".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as? UINavigationController
        if let dis = navController?.topViewController as? EditZonesVC {
            
            dis.delegate = self

        }
        if let dis = navController?.topViewController as? EditCitiesVC {
            dis.delegate = self
            dis.zoneID = newZoneID
        }
        if let dist = navController?.topViewController as? EditCategoryVC {
            dist.delegate = self
        }
        if let dist = navController?.topViewController as? EditMaterialVC {
            dist.categoryID = newCategoryID
            dist.delegate = self
        }
        if let dist = navController?.topViewController as? SubcategoriesEditVC {
            dist.materialID = newMaterialID
            dist.delegate = self
        }
    }
}
extension EditPlaceVC :zoneSelectedDelegate {
    func zoneSelected(selectedZoneName: String, selectedZoneID: String) {
        zoneName = selectedZoneName
        newZoneID = selectedZoneID
        zonename.text = zoneName
    }
}
extension EditPlaceVC: cityDelegate {
    func cities(cityName: String, cityID: String) {
        newCityName = cityName
        newCityID = cityID
        cityTF.text = newCityName
    }
}
extension EditPlaceVC: selectedCategory {
    func newCategory(categoryName: String, categoryID: String) {
        newCategoryName = categoryName
        newCategoryID = categoryID
        category.text = newCategoryName
    }
}
extension EditPlaceVC: materialSelected {
    func materialsSelected(materialName: String, materialID: String) {
        newMaterialName = materialName
        newMaterialID = materialID
        
        materialTF.text = newMaterialName
    }
}
extension EditPlaceVC: subCategories {
    func categories(subName: String, subID: String) {
        newSubName = subName
        newSubID = subID
        subCategoryTF.text = newSubName
    }
}



