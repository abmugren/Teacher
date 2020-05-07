
//
//  PlaceInfoVC.swift
//  Indexzone
//
//  Created by MacBook on 2/28/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON
import PKHUD
import Cosmos
import SDWebImage
class PlaceInfoVC: UIViewController {
    
    @IBOutlet weak var emailwtsapp: UILabel!
    @IBOutlet weak var imageselect: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var adddescription: UILabel!
    @IBOutlet weak var addzone: UILabel!
    @IBOutlet weak var logopic: CircularImage!
    @IBOutlet weak var totalfav: UILabel!
    @IBOutlet weak var favicon: UIButton!
    @IBOutlet weak var faceshow: UIButton!
    @IBOutlet weak var instgramshow: UIButton!
    @IBOutlet weak var whatsappshow: UIButton!
    @IBOutlet weak var yoytubeshow: UIButton!
    @IBOutlet weak var websiteshow: UIButton!
    @IBOutlet weak var emailshow: UIButton!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var callshow: UIButton!
    @IBOutlet weak var contactlabel: UILabel!
    @IBOutlet weak var subTF: UILabel!
    @IBOutlet weak var materialTF: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var totalrate = 0
    var placeID = UserDefaults.standard.value(forKey: "placeID") as! String
    
    let url = APIKeys().GET_PLACE_ID
    var phNo = ""
    var cantap:Bool = false
    var facebook = ""
    var instgram = ""
    var youtube = ""
    var website = ""
    var email = ""
    var whatsapp = ""
    var images = [String](arrayLiteral: "","","","","","")
    var localSource = [InputSource]()
    
    var zoneEN: String!
    var zoneAR: String!
    
    var cityEN: String!
    var cityAR: String!
    
    var userPlaces = PlacesInfo()
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func facebook(_ sender: Any) {
        let url = URL(string: "https://\(facebook)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func website(_ sender: Any) {
        let url = URL(string: "https://\(website)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
        
    }
    @IBAction func instgram(_ sender: Any) {
        let url = URL(string: "https://\(instgram)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
    }
    @IBAction func youtube(_ sender: Any) {
        let url = URL(string: "https://\(youtube)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
    }
    @IBAction func whatsapp(_ sender: Any) {
//        if let phoneUrl = URL(string: "telprompt:\(whatsapp)")
//        {
//            print(phoneUrl)
//            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
//        }
        let urlWhats = "whatsapp://send?phone=\(whatsapp)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    @IBAction func emailbtn(_ sender: Any) {
        let email = self.email
        if let url = URL(string: "mailto:\(email)") {
            print(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
    
    @IBAction func call(_ sender: Any) {
        if let phoneUrl = URL(string: "telprompt:\(phNo)")
        {
            print(phoneUrl)
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        contactlabel.text = "contact".localized
        self.cantap = false
        self.images = [String]()
        self.localSource = [InputSource]()
        self.indicator.show()
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }
    }
    @IBAction func deleteplace(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention".localized, message: "messegeDelete".localized, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            WebServices.instance.removeuserplace(id: self.placeID, completion: { (status,error ) in
                if status{
                    print(self.placeID)
                    print(status)
                    self.navigationController?.popViewController(animated: true)
                }
                else if error == ""{
                }
            })
            
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
        
    }
    
    @IBAction func faviconbtn(_ sender: Any) {
        (sender as! UIButton).pulsate()

        if favicon.image(for: .normal) == #imageLiteral(resourceName: "favorite-heart-button (6)24"){
            WebServices.instance.addPlaceTofavorite(placeID: placeID, completion: { (status, error) in
                if status{
                    self.favicon.setImage(#imageLiteral(resourceName: "favorite (7)24"), for: .normal)
                    print("Fav Done")
                    self.totalrate = self.totalrate + 1
                    self.totalfav.text = String(self.totalrate)
                    
                }else if error == ""{
                    print("error")
                }
            })
        }else if favicon.image(for: .normal) == #imageLiteral(resourceName: "favorite (7)24"){
            WebServices.instance.RemovePlaceFromfavorite(placeID: placeID, completion: { (status,error ) in
                if status{
                    self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (6)24"), for: .normal)
                    print("Not Fav Done")
                    self.totalrate = self.totalrate - 1
                    self.totalfav.text = String(self.totalrate)
                    
                }else if error == ""{
                    print("ERROR")
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
            HUD.show(.progress)
            
            Alamofire.request("\(url)?id=\(placeID)", method: .get , encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    HUD.hide()
                    print("\(self.url)?id=\(self.placeID)")
                    let json = JSON(value)
                    print("All places",json)
                    if let category  = json["categoryID"].dictionary{
                        if APPLANGUAGE == "ar"{
                            self.category.text = category["titleAr"]?.string
                        }else{
                            self.category.text = category["titleEN"]?.string
                        }
                        
                    }
                    if let zone  = json["zoneID"].dictionary{
                        if APPLANGUAGE == "ar"{
                            
                            self.zoneAR = zone["titleAr"]?.string
                        }else{
                            self.zoneEN = zone["titleEN"]?.string
                        }
                    }
                    
                    if let city  = json["cityID"].dictionary{
                        if APPLANGUAGE == "ar"{
                            
                            self.cityAR = city["titleAr"]?.string
                        }else{
                            self.cityEN = city["titleEN"]?.string
                        }
                    }
                    if let subs  = json["subCategoryID"].dictionary{
                        if APPLANGUAGE == "ar"{
                            self.subTF.text = (subs["titleAr"]?.string)!
                        }else{
                            self.subTF.text = (subs["titleEN"]?.string)!
                        }
                        
                    }
                    if let material  = json["materialID"].dictionary{
                        if APPLANGUAGE == "ar"{
                            
                            self.materialTF.text = (material["titleAr"]?.string)!
                            
                        }else{
                            
                            self.materialTF.text = (material["titleEN"]?.string)!
                        }
                        
                    }
                    
                    
                    
                    
                    if let urlPath = json["logo"].string{
                        let placePhoto = URL(string:"\(urlPath)")!
                        self.logopic.sd_setImage(with: placePhoto)
                    }
                    self.facebook = json["face"].string!
                    if self.facebook == ""{
                        self.faceshow.isHidden = true
                    }else{
                        self.faceshow.isHidden = false
                    }
                    self.instgram = json["insta"].string!
                    if self.instgram == ""{
                        self.instgramshow.isHidden = true
                    }else{
                        self.instgramshow.isHidden = false
                    }
                    if self.youtube == ""{
                        self.yoytubeshow.isHidden = true
                    }else{
                        self.yoytubeshow.isHidden = false
                    }
                    self.website = json["website"].string!
                    if self.website == ""{
                        self.websiteshow.isHidden = true
                    }else{
                        self.websiteshow.isHidden = false
                    }
                    self.whatsapp = json["whats"].string!
                    if self.whatsapp == ""{
                        self.whatsappshow.isHidden = true
                    }else if self.whatsapp != ""{
                        self.whatsappshow.isHidden = false
                    }
                    self.email = json["email"].string!
                    if self.email == ""{
                        self.emailshow.isHidden = true
                    }else if self.email != ""{
                        
                        self.emailshow.isHidden = false
                    }
                    self.callshow.isHidden = false
                    self.phNo = json["mobile"].string!
                    //       self.images[0] = json["img1"].string!
                    //     self.images[1] = json["img2"].string!
                    //   self.images[2] = json["img3"].string!
                    //    self.images[3] = json["img4"].string!
                    //    self.images[4] = json["img5"].string!
                    //    self.images[5] = json["img6"].string!
                    if let img1 = json["img1"].string {
                        if img1 != ""{
                            self.images.append(img1)
                        }else{
                            //self.images[0] = ""
                        }
                    }
                    if let img2 = json["img2"].string {
                        if img2 != ""{
                            self.images.append(img2)
                        }else{
                            //self.images[1] = ""
                        }
                    }
                    if let img3 = json["img3"].string {
                        if img3 != ""{
                            self.images.append(img3)
                        }else{
                            //self.images[2] = ""
                        }
                    }
                    if let img4 = json["img4"].string {
                        if img4 != ""{
                            self.images.append(img4)
                        }else{
                            //self.images[3] = ""
                        }
                    }
                    if let img5 = json["img5"].string {
                        if img5 != ""{
                            self.images.append(img5)
                        }else{
                            //self.images[4] = ""
                        }
                    }
                    if let img6 = json["img6"].string {
                        if img6 != ""{
                            self.images.append(img6)
                        }else{
                            //self.images[5] = ""
                        }
                    }
                    for image in self.images{
                        if image != "" {
                            let url = URL(string: image)
                            let x = SDWebImageSource(url: url!)
                            self.localSource.append(x)
                            if self.localSource.count == self.images.count{
                                self.updateSlideShow()
                            }
                        }else {
                            let x = ImageSource(image: #imageLiteral(resourceName: "defaultImage"))
                            self.localSource.append(x)
                            if self.localSource.count == self.images.count{
                                self.updateSlideShow()
                            }
                            
                        }
                    }
                    let langit = json["lang"].doubleValue
                    let latit = json["lat"].doubleValue
                    
                    UserDefaults.standard.set(langit, forKey: "langit")
                    UserDefaults.standard.set(latit, forKey: "latit")
                    
                    self.name.text = json["title"].stringValue
                    self.totalrate = json["totalFav"].intValue
                    self.totalfav.text = String(self.totalrate)
                    
                    self.rating.rating = json["totalRate"].doubleValue
                    self.adddescription.text = json["description"].stringValue
                case .failure(let error):
                    print(error)
                    HUD.hide()
                }
                
                if(APPLANGUAGE == "en"){
                    self.addzone.text = self.zoneEN + " / " + self.cityEN
                }
                else {
                    self.addzone.text = self.zoneAR + " / " + self.cityAR
                }
                
                
            }
            
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

        
        WebServices.instance.Checkfavorite { (status) in
            if status == -1{
                print("asdasdadsasd",status)
                self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (6)24"), for: .normal)
            }else if status == 1{
                print(status)
                self.favicon.setImage(#imageLiteral(resourceName: "favorite (7)24"), for: .normal)
            }
        }
        
        emailwtsapp.isHidden = true
        imageselect.isHidden = true
        self.websiteshow.isHidden = true
        self.instgramshow.isHidden = true
        self.whatsappshow.isHidden = true
        self.yoytubeshow.isHidden = true
        self.faceshow.isHidden = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        
        
    }
    
    @objc func didTap() {
        if self.cantap == true {
            slideshow.presentFullScreenController(from: self)
        }
        
    }
    
    func updateSlideShow(){
        
        
        self.indicator.hide()
        self.cantap = true
        
        self.slideshow.setImageInputs(self.localSource)

        self.slideshow.layer.cornerRadius = 2
//        self.slideshow.layer.shadowColor = UIColor.black.cgColor
//        self.slideshow.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
//        self.slideshow.layer.shadowOpacity = 0.5
//        self.slideshow.layer.shadowRadius = 5.0 //Here your control your blur
        self.slideshow.layer.masksToBounds =  false
//        self.slideshow.backgroundColor = UIColor(hexString: "1c3c74")
        self.slideshow.slideshowInterval = 5.0
        self.slideshow.pageControlPosition = PageControlPosition.underScrollView
//        self.slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        self.slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        self.slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        self.slideshow.activityIndicator = DefaultActivityIndicator()
        self.slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
    }
}
