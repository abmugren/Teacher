//
//  ChangePasswordVC.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
class ChangePasswordVC: UIViewController {
    @IBOutlet weak var oldpassword: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var edittitle: UIButton!
    @IBOutlet weak var exittitle: UIButton!
    @IBOutlet weak var changetitle: UILabel!
    
    let oldpass = UserDefaults.standard.value(forKey: "password")
    override func viewDidLoad() {
        super.viewDidLoad()
        oldpassword.placeholder = "oldpass".localized
        newpassword.placeholder = "newpass".localized
        confirmpassword.placeholder = "confirmpass".localized
        edittitle.setTitle("EditTitle".localized, for: .normal)
        exittitle.setTitle("ExitTitle".localized, for: .normal)
        changetitle.text = "ChangePasswordtitle".localized
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func agreeBtn(_ sender: Any) {
        (sender as! UIButton).shake()
        if oldpassword.text?.isEmpty == true || newpassword.text?.isEmpty == true || confirmpassword.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "EnterEmptyFields".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if oldpassword.text?.isEmpty == true && newpassword.text?.isEmpty == true && confirmpassword.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "EnterEmptyFields".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if oldpassword.text! != oldpass as! String{
            AlertHandler().displayMyAlertMessage(message: "IncorreectOldPassword", title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if oldpassword.text! == oldpass as! String{
            if newpassword.text! != confirmpassword.text!{
                AlertHandler().displayMyAlertMessage(message: "Confirmationpassword", title: "Wrong".localized, okTitle: "ok".localized, view: self)
            }
            else{
                if isConnectedToNetwork() == true {
                    print("Internet connection OK")
                    HUD.show(.progress)
                    WebServices.instance.changepassword(password: newpassword.text!, completion: { (status,error ) in
                        if status {
                            HUD.flash(.success, delay: 2.0)
                            self.navigationController?.popViewController(animated: true)
                        }
                        else if error == ""{
                            HUD.flash(.error, delay: 2.0)
                        }
                    })
                } else {
                    AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
                }
            }
        }
        
    }
    @IBAction func exitBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
