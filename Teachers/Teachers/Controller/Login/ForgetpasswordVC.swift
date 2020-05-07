//
//  ForgetpasswordVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
class ForgetpasswordVC: UIViewController {
    
    @IBOutlet weak var exit: UIButton!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var forgetpass: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(APPLANGUAGE == "en"){
            email.textAlignment = .left
            
        }
        else {
            email.textAlignment = .right            
        }

        send.setTitle("SendTitle".localized, for: .normal)
        email.placeholder = "email".localized
        exit.setTitle("ExitTitle".localized, for: .normal)
        forgetpass.text = "forgetpass".localized
        email.placeHolderColor = hexStringToUIColor(hex: "1C3C74", opacity: 1.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func sendbtn(_ sender: Any) {
        HUD.show(.progress)
        if (self.email.text!.isEmpty) == true {
            HUD.hide()
            AlertHandler().displayMyAlertMessage(message: "Enteremail".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else{
            WebServices.instance.forgetpassword(email: email.text!) { (status) in
                if status{
                    HUD.hide()
                     AlertHandler().displayMyAlertMessage(message: "Yourpasswordwassendtoyouremail".localized, title: "Success".localized, okTitle: "ok".localized, view: self)
                }else{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Youremailis".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                }
            }
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
