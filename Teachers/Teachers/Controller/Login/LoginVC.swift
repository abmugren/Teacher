//
//  LoginVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import AVFoundation
import IQKeyboardManagerSwift
class LoginVC: UIViewController {
    
    @IBOutlet weak var skiplogin: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logintitle: UIButton!
    @IBOutlet weak var regtitle: UIButton!
    @IBOutlet weak var forgetpassword: UIButton!
  
    @IBOutlet weak var appname: UILabel!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    let str = "استاذ خصوصي"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(APPLANGUAGE == "en"){
            email.textAlignment = .left
            password.textAlignment = .left

        }
        else {
            email.textAlignment = .right
            password.textAlignment = .right

        }

        logintitle.setTitle("login".localized, for: .normal)
        regtitle.setTitle("register".localized, for: .normal)
        email.placeholder = "emailplace".localized
        password.placeholder = "password".localized
        forgetpassword.setTitle("forget".localized, for: .normal)
        skiplogin.setTitle("skiplogin".localized, for: .normal)
        email.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        password.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.onclickView()
        }
    }
    @objc func onclickView(){
        appname.text = ""
            for i in self.str{
                AudioServicesPlaySystemSound(1306)
                self.appname.text! += "\(i)"
                RunLoop.current.run(until: Date()+0.1)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func skiplogin(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "HomeNC")
        
        self.present(controller, animated: true, completion: nil)
        UserDefaults.standard.removeObject(forKey: "id")

        //        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
        //        self .present(controller!, animated: true, completion: nil)
        
    }
    
    @IBAction func login(_ sender: Any) {
        if (self.email.text!.isEmpty) == true {
            AlertHandler().displayMyAlertMessage(message: "Enteremail".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if (self.password.text!.isEmpty) == true{
            AlertHandler().displayMyAlertMessage(message: "Enterpassword".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else{
            HUD.flash(.progress, delay: 10.0)

            WebServices.instance.login(email: self.email.text!, password: self.password.text!, completion: { (status, error)  in
                if status {
                    HUD.flash(.success, delay: 1.0)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
                    self .present(controller!, animated: true, completion: nil)
                }else if error == "Authentication failed. User not found."{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Authenticationfailed.Usernotfound".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }else if error == "Authentication failed. Wrong password."{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Authenticationfailed.Wrongpassword".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }else if error == "this account is suspend !!!"{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "thisaccountissuspend".localized, title: "Wrong", okTitle: "ok".localized, view: self)
                }



            })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated:true)
        self.navigationController?.navigationBar.tintColor = .white
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
