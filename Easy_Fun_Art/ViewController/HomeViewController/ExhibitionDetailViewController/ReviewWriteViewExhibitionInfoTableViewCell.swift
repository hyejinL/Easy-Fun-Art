//
//  ReviewWriteViewExhibitionInfoTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 2. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ReviewWriteViewExhibitionInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    @IBOutlet weak var galleryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
