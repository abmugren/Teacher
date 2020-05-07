//
//  RatePlaceVC.swift
//  Indexzone
//
//  Created by MacBook on 4/8/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Cosmos
import PKHUD
class RatePlaceVC: UIViewController {
    @IBOutlet weak var rate: CosmosView!
    @IBOutlet weak var ratebutton: UIButton!
    @IBOutlet weak var ratelabel: UILabel!
    var placeID = UserDefaults.standard.value(forKey: "placeID") as! String
    var userID = UserDefaults.standard.value(forKey: "id") as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        print(placeID)
        print(userID)
        ratelabel.text = "rate".localized
        ratebutton.setTitle("ratebtn".localized, for: .normal)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ratebtn(_ sender: Any) {
        WebServices.instance.ratePlace(userID: userID, placeID: placeID, rate: self.rate.rating) { (status) in
            if status {
                print(status)
                HUD.flash(.success)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        HUD.flash(.progress)
        WebServices.instance.getUserRate(userID: userID, placeID: placeID) { (status) in
            self.rate.rating = status
            print("status",status)
        }
    }
}
