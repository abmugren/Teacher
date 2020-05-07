//
//  AddedPlace.swift
//  Indexzone
//
//  Created by MacBook on 2/25/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Cosmos
import PKHUD
class AddedPlace: UITableViewCell {
    
    @IBOutlet weak var totalratelabel: UILabel!
    @IBOutlet weak var placetitle: UILabel!
    @IBOutlet weak var placelogo: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var totalrate: CosmosView!
    @IBOutlet weak var totalfav: UILabel!
    @IBOutlet weak var addzone: UILabel!
    @IBOutlet weak var statusImage: CircularImage!
    @IBOutlet weak var statuscolor: UIImageView!
    
    var index: IndexPath!
    var btnDelegate: btnOption!
    var placeID = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func removePlace(_ sender: Any) {
        btnDelegate.btnTaped(at: index)
        WebServices.instance.removeuserplace(id: placeID, completion: { (status,error ) in
            if status{
                print(self.placeID)
                print(status)
            }
            else if error == ""{
            }
        })

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
