//
//  MyExhibitionCollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MyExhibitionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myExhibitionImageView: UIImageView!
    @IBOutlet weak var myExhibitionTitleLabel: UILabel!
    
    var exhibitionId = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
