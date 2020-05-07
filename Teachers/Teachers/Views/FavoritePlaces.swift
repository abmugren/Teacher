//
//  FavoritePlaces.swift
//  Indexzone
//
//  Created by MacBook on 3/6/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Cosmos
class FavoritePlaces: UITableViewCell {
    @IBOutlet weak var totalratelabel: UILabel!
    @IBOutlet weak var placetitle: UILabel!
    @IBOutlet weak var placelogo: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var totalrate: CosmosView!
    @IBOutlet weak var totalfav: UILabel!
    @IBOutlet weak var addzone: UILabel!
    var placeID = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
