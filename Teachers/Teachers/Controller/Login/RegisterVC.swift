//
//  RegisterVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import IQKeyboardManagerSwift
class RegisterVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var agreelabel: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var checkeddata: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var regtitle: UIButton!
    @IBOutlet weak var gender: UITextField!
    
    var GenderArray: [(uniqId: String, type: String)] =
        [("1", "Male"), ("2", "Female")]
    var GenderAR: [(uniqId: String, type: String)] =
        [("1", "ذكر"), ("2", "انثي")]
    

    var typeID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if APPLANGUAGE == "ar" {
            name.textAlignment = .right
            email.textAlignment = .right
            mobile.textAlignment = .right
            gender.textAlignment = .right
            password.textAlignment = .right
            confirmPassword.textAlignment = .right
            
        }
        else {
            name.textAlignment = .left
            email.textAlignment = .left
            mobile.textAlignment = .left
            gender.textAlignment = .left
            password.textAlignment = .left
            confirmPassword.textAlignment = .left
        }
        
        
        setPickerToField(textField:gender , title: "selectgender".localized)
        regtitle.setTitle("register".localized, for: .normal)
        email.placeholder = "email".localized
        password.placeholder = "password".localized
        mobile.placeholder = "mobile".localized
        name.placeholder = "name".localized
        gender.placeholder = "selectg".localized
        confirmPassword.placeholder = "confirmpass".localized
        agreelabel.setTitle("Agree".localized, for: .normal)
        mobile.keyboardType = UIKeyboardType.phonePad
//        countryCode.isUserInteractionEnabled = false
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        password.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        email.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        name.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        gender.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        confirmPassword.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        mobile.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GenderArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if APPLANGUAGE == "ar"{
            return GenderAR[row].type
        }else{
            return GenderArray[row].type
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if APPLANGUAGE == "ar" {
            self.gender.text = GenderAR[row].type
        }else{
            self.gender.text = GenderArray[row].type
        }
        if APPLANGUAGE == "ar" {
            self.typeID = GenderAR[row].uniqId
            print(self.typeID)
        }else{
            self.typeID = GenderArray[row].uniqId
            print(self.typeID)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardHeight! / 2
        }else{
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight! / 2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
    }
    
    @IBAction func AcceptTerms(_ sender: Any) {
        if checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked (1)24"){
            checkeddata.setImage(#imageLiteral(resourceName: "checked24"), for: .normal)
            (sender as! UIButton).pulsate()
        }else if checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked24"){
            checkeddata.setImage(#imageLiteral(resourceName: "checked (1)24"), for: .normal)
        }
    }
    @IBAction func register(_ sender: Any) {
        if (name.text?.isEmpty)! == true {
            AlertHandler().displayMyAlertMessage(message: "EnterName".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if (name.text?.characters.count)! < 8{
            AlertHandler().displayMyAlertMessage(message: "EnterFullname".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if (email.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "Enteremail".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if (email.text?.range(of:"@") == nil || email.text?.range(of:".") == nil) {
            AlertHandler().displayMyAlertMessage(message: "EnterValidemail".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
            return
        }
        else if (mobile.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "Entermobile".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if (password.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "Enterpassword".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if password.text! != confirmPassword.text!{
            AlertHandler().displayMyAlertMessage(message: "PasswordIsn'tMatch".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if  checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked (1)24"){
            AlertHandler().displayMyAlertMessage(message: "agreeterms".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }else if  (password.text?.characters.count)! < 6{
            AlertHandler().displayMyAlertMessage(message: "passwordpoor".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }
        else{
            HUD.show(.progress)
            WebServices.instance.register(name: name.text!, email: email.text!, mobile: "\(self.countryCode.text!)\(mobile.text!)", password: password.text!, gender: typeID, completion: { (status , error) in
                
                if status {
                    HUD.flash(.success, delay: 2.0)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "login")
                    self .present(controller!, animated: true, completion: nil)
                }else if error == ""{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "WrongEmailOrPassword".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            })
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
