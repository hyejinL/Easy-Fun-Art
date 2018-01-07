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
    @IBOutlet weak var exhibitionRatingLabel: UILabel!
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    @IBOutlet weak var exhibitionDateLabel: UILabel!
    @IBOutlet weak var exhibitionLocationLabel: UILabel!
    @IBOutlet weak var goDocentButton: UIButton!
    @IBOutlet weak var goExhibitionDetailView: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var exhibitionId = 0
    var galleryId = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
