//
//  PlaceCollection.swift
//  Indexzone
//
//  Created by MacBook on 3/8/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Cosmos
class PlaceCollection: UICollectionViewCell {
    
    @IBOutlet weak var logoPic: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var totalfav: UILabel!
    @IBOutlet weak var totalView: UILabel!
    @IBOutlet weak var totalrate: UILabel!
}
