//
//  SplachViewController.swift
//  Teachers
//
//  Created by MacBook on 4/9/19.
//  Copyright © 2019 Technosaab. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class SplachViewController: UIViewController {
    @IBOutlet weak var gifload: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gifload.image = UIImage.gif(name: "الاخير 20")

    perform(#selector(SplachViewController.startup), with: nil, afterDelay: 4)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func startup(){
        if UserID == nil {
            let controller = storyboard?.instantiateViewController(withIdentifier: "login")
            self.present(controller!, animated: true, completion: nil)

        }else{
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC")
            self.present(controller!, animated: true, completion: nil)
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
