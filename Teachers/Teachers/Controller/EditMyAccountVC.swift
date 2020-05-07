//
//  EditMyAccountVC.swift
//  Indexzone
//
//  Created by MacBook on 1/23/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
class EditMyAccountVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var countrycode: UITextField!
    @IBOutlet weak var propic: UIImageView!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var EditTitle: UIButton!
    @IBOutlet weak var exitTitle: UIButton!
    @IBOutlet weak var editimage: UIButton!
    
    
    let fullname = UserDefaults.standard.value(forKey: "fullname") as! String
    let emailaddress = UserDefaults.standard.value(forKey: "email") as! String
    let mobilenum = UserDefaults.standard.value(forKey: "mobile") as! String
    // var imgpath :NSData = NSData()
    var imguser = UserDefaults.standard.value(forKey: "personalImg") as? String
    override func viewDidLoad() {
        EditTitle.setTitle("EditTitle".localized, for: .normal)
        exitTitle.setTitle("ExitTitle".localized, for: .normal)
        
        countrycode.isUserInteractionEnabled = false
        super.viewDidLoad()
        editimage.flash()
        name.text! = fullname
        email.text! = emailaddress
        let MobileNo = mobilenum
        let result4 = String(MobileNo.dropFirst(3))
        mobile.text! = result4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profilePic(_ sender: Any) {
        
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "PhotoOrCamera".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        HUD.show(.progress)
        WebServices.instance.uploadImage(image: image) { (path) in
            if let urlPath = path{
                let messeagePhoto = URL(string:"\(urlPath)")!
                self.imguser = path!
                print("Message",messeagePhoto)
                HUD.flash(.success, delay: 2.0)
                self.propic.image = image
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editBtn(_ sender: Any) {
        (sender as! UIButton).shake()
        print(mobilenum)
        print(emailaddress)
        print(mobile.text!)
        print(imguser)
        if mobile.text! == "" || email.text! == "" || name.text! == "" {
            AlertHandler().displayMyAlertMessage(message: "EnterEmptyFields".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if "\(countryCode.text!)\(mobile.text!)" == mobilenum && email.text! == emailaddress{
            HUD.show(.progress)
            WebServices.instance.update(name: name.text!,img:imguser!, completion: { (status,error ) in
                if status{
                    HUD.flash(.success, delay: 2.0)
                    self.navigationController?.popViewController(animated: true)
                    UserDefaults.standard.set(self.imguser, forKey: "personalImg")

                }
                else if error == ""{
                    HUD.flash(.error, delay: 2.0)
                    AlertHandler().displayMyAlertMessage(message: "EmailOrMobileExists".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        }
        else if "\(countryCode.text!)\(mobile.text!)" == mobilenum && email.text! != emailaddress{
            HUD.show(.progress)
            WebServices.instance.update(name: name.text!,email:email.text!,img:imguser!, completion: { (status,error ) in
                if status{
                    HUD.flash(.success, delay: 2.0)
                    self.navigationController?.popViewController(animated: true)
                    UserDefaults.standard.set(self.imguser, forKey: "personalImg")

                    
                }
                else if error == ""{
                    HUD.flash(.error, delay: 2.0)
                    AlertHandler().displayMyAlertMessage(message: "EmailOrMobileExists".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        }
        else if "\(countryCode.text!)\(mobile.text!)" != mobilenum && email.text! == emailaddress{
            HUD.show(.progress)
            WebServices.instance.update(name: name.text!,mobile:"\(countryCode.text!)\(mobile.text!)",img:imguser!, completion: { (status,error ) in
                if status{
                    HUD.flash(.success, delay: 2.0)
                    self.navigationController?.popViewController(animated: true)
                    UserDefaults.standard.set(self.imguser, forKey: "personalImg")

                }
                else if error == ""{
                    HUD.flash(.error, delay: 2.0)
                    AlertHandler().displayMyAlertMessage(message: "EmailOrMobileExists".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        } else if "\(countryCode.text!)\(mobile.text!)" != mobilenum && email.text! != emailaddress{
            HUD.show(.progress)
            WebServices.instance.update(email:email.text!, mobile:"\(countryCode.text!)\(mobile.text!)", name: name.text!,img:imguser!, completion: { (status,error ) in
                if status{
                    HUD.flash(.success, delay: 2.0)
                    self.navigationController?.popViewController(animated: true)
                    UserDefaults.standard.set(self.imguser, forKey: "personalImg")
                }
                else if error == ""{
                    HUD.flash(.error, delay: 2.0)
                    AlertHandler().displayMyAlertMessage(message: "EmailOrMobileExists".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
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
    
}
