
//
//  ExhibitionReviewTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import Cosmos

class ExhibitionReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var previewDateLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
