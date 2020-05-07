//
//  ProfileVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var editmyaccount: UIButton!
    @IBOutlet weak var changepassword: UIButton!
    @IBOutlet weak var addedplaces: UIButton!
    @IBOutlet weak var signout: UIButton!
    @IBOutlet weak var uiviewSkip: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editmyaccount.setTitle("editmyaccount".localized, for: .normal)
        changepassword.setTitle("changepass".localized, for: .normal)
        addedplaces.setTitle("addedplace".localized, for: .normal)
        signout.setTitle("signout".localized, for: .normal)
        
        // Do any additional setup after loading the view.
        // profileimg.image! = UIImage(data: image as! Data)!
    }
    @IBAction func signOut(_ sender: Any) {
        let actionsheet = UIAlertController(title: "logout".localized, message: "Areyousuretomakelogout?".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "logout".localized, style: .default, handler: { (action:UIAlertAction) in
            UserDefaults.standard.removeObject(forKey: "id")
            UserDefaults.standard.removeObject(forKey: "personalImg")
            UserDefaults.standard.removeObject(forKey: "status")
            UserDefaults.standard.removeObject(forKey: "fullname")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "mobile")
            UserDefaults.standard.removeObject(forKey: "password")
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "login")
            self .present(controller!, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationItem.title = "Profile".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        if UserDefaults.standard.value(forKey: "id") == nil{
            uiviewSkip.alpha = 1
            let alertController = UIAlertController(title: "Attention".localized, message: "Gotologinfirsttoallowyoutoshowprofile".localized, preferredStyle: .alert)
            
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
            name.text! = UserDefaults.standard.value(forKey: "fullname") as! String
            email.text! = UserDefaults.standard.value(forKey: "email") as! String
            if UserDefaults.standard.value(forKey: "personalImg") as? String != ""{
                let urlPath = UserDefaults.standard.value(forKey: "personalImg") as! String
                let userPhoto = URL(string:"\(urlPath)")
                self.profileimg.sd_setImage(with: userPhoto)
            }else{
                self.profileimg.image = #imageLiteral(resourceName: "edit_user")
            }
        }
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
