//
//  ExhibitionDetailInfo2CollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionDetailInfo2CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exhibitionTextLabel: UILabel!
    @IBOutlet weak var cellWidthConst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.cellWidthConst.constant = UIScreen.main.bounds.size.width
    }
}
