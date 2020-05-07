//
//  MyTabBarVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class MyTabBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 2
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
        switch item.tag {
        case 0:
            self.selectedIndex = 0
        case 1:
            self.selectedIndex = 1
        case 2:
            self.selectedIndex = 2
        case 3:
            self.selectedIndex = 3
        case 4:
            self.selectedIndex = 4
            self.tabBarItem?.title = "Profile".localized

        default:
            break
        }

    }
    
    // UITabBarControllerDelegate


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
