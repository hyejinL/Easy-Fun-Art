//
//  ReviewWriteViewContentTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 2. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ReviewWriteViewContentTableViewCell: UITableViewCell {
    @IBOutlet weak var reviewContentTextView: UITextView!
    @IBOutlet weak var openCameraButton: UIButton!
    @IBOutlet weak var openGalleryButton: UIButton!
    @IBOutlet weak var reviewContentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewContentImageView: UIImageView!
    @IBOutlet weak var reviewContentImageAlertLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(viewHeight: CGFloat) {
        reviewContentTextViewHeight.constant = (viewHeight*350)/667-143
    }
    
    func noImage() {
        reviewContentImageAlertLabel.isHidden = true
    }
    
    func containImage() {
        reviewContentImageAlertLabel.isHidden = false
    }
}
