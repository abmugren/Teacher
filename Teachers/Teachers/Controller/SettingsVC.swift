//
//  SettingsVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var changelang: UIButton!
    @IBOutlet weak var policy: UIButton!
    @IBOutlet weak var customer: UIButton!
    
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var aboutapp: UIButton!
    @IBOutlet weak var terms: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changelang.setTitle("changelang".localized, for: .normal)
        policy.setTitle("policy".localized, for: .normal)
        rate.setTitle("rate".localized, for: .normal)
        share.setTitle("share".localized, for: .normal)
        terms.setTitle("terms".localized, for: .normal)
        aboutapp.setTitle("aboutapp".localized, for: .normal)
        customer.setTitle("customer".localized, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func share(_ sender: Any) {
        shareApp(link: "https://apps.apple.com/us/app/%D8%A3%D8%B3%D8%AA%D8%A7%D8%B0-%D8%AE%D8%B5%D9%88%D8%B5%D9%89/id1398156688", controller: self )
    }
    @IBAction func rateApp(_ sender: Any) {
        let iTunesLink = "https://apps.apple.com/us/app/%D8%A3%D8%B3%D8%AA%D8%A7%D8%B0-%D8%AE%D8%B5%D9%88%D8%B5%D9%89/id1398156688"
        if let aLink = URL(string: iTunesLink) {
            UIApplication.shared.open(aLink)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func customerAction(_ sender: Any) {
        
        if UserDefaults.standard.value(forKey: "id") == nil{
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


        }
        else {
            performSegue(withIdentifier: "cust", sender: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "id") == nil{
            customer.isEnabled = true
        }else{
            customer.isEnabled = true
        }
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "1c3c74")
        self.navigationItem.title = "Setting".localized
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
    
}
