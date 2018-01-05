//
//  MainRecoCollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import Cosmos

class MainRecoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var exhibitionRatingView: CosmosView!
    @IBOutlet weak var goDocentButton: UIButton!
    @IBOutlet weak var goExhibitionDetailView: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
