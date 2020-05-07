//
//  CircularImage.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {
    
        override func layoutSubviews() {
            self.layer.cornerRadius = self.frame.size.width/2
            self.layer.masksToBounds = true
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
            self.layer.shadowOpacity = 0.4
            self.layer.shadowRadius = 3.0
            self.layer.borderWidth = 0.5
            
    }
   



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
