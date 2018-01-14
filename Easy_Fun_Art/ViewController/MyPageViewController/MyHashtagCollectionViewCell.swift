//
//  MyHashtagCollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MyHashtagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hashtagCellHeight: NSLayoutConstraint!
    @IBOutlet weak var hashtaglabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.backgroundColor = .white
        self.layer.borderWidth = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        hashtagCellHeight.constant = (UIScreen.main.bounds.height*34)/667
    }

}
