//
//  ChangeLangVC.swift
//  Indexzone
//
//  Created by MacBook on 3/8/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class ChangeLangVC: UIViewController {

    @IBOutlet weak var arLabel: UIButton!
    @IBOutlet weak var enLabel: UIButton!
    @IBOutlet weak var changelanguage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        changelanguage.text = "ChangeLang".localized
        arLabel.setTitle("عربي", for: .normal)
        enLabel.setTitle("English", for: .normal)
        // Do any additional setup after loading the view.
        if APPLANGUAGE == "ar"{
            enLabel.flash()
        }else{
            arLabel.flash()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Change(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            LanguageManger().changeToLanguage("ar", self)
        }else{
            LanguageManger().changeToLanguage("en", self)
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
