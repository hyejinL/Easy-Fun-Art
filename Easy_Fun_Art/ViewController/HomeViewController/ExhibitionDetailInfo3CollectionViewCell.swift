//
//  ExhibitionDetailInfo3CollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionDetailInfo3CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var cellWidthConst: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.cellWidthConst.constant = UIScreen.main.bounds.size.width
    }
    
    func configure(authorImage: String?, authorText:String?) {
        authorImageView.layer.masksToBounds = true
        authorImageView.layer.cornerRadius = authorImageView.frame.width/2
        authorImageView.layer.borderColor = #colorLiteral(red: 0.9926154017, green: 0.8786800504, blue: 0, alpha: 1)
        authorImageView.layer.borderWidth = 1.0
        
        authorTextLabel.text = authorText
        guard let image = authorImage else { return }
        authorImageView.imageFromUrl(image, defaultImgPath: "")

    }

}
