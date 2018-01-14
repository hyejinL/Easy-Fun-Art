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
    @IBOutlet weak var likeButton: ToggleButton!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    
    var type = "theme1"
    var exhibitionTheme: [HomeExhibition]?
    var exhibitionId = 0
    var galleryId = 0
    var exhibitionImageURL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.falseImage = #imageLiteral(resourceName: "btn_main_like_off")
        likeButton.trueImage = #imageLiteral(resourceName: "btn_main_like_on")
        
        likeButton.layer.borderColor = #colorLiteral(red: 0.6498134136, green: 0.660738945, blue: 0.6677950025, alpha: 1)
        likeButton.layer.borderWidth = 0.5
        goDocentButton.layer.borderColor = #colorLiteral(red: 0.6498134136, green: 0.660738945, blue: 0.6677950025, alpha: 1)
        goDocentButton.layer.borderWidth = 0.5

        likeButton.addTarget(self, action: #selector(likeExhibition(_:)), for: .touchUpInside)
    }
    
    @objc func likeExhibition(_ button: UIButton) {
        guard let cell = button.superview?.superview?.superview as? MainRecoCollectionViewCell else { return }
        
        let exhibitionText = cell.exhibitionTitleLabel.text
        
        HomeService.shareInstance.likeExhibition(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let likeFlag):
                print(likeFlag)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "likeExhibition"), object: self, userInfo: ["cellId":self.exhibitionId, "theme":self.exhibitionTheme, "likeFlag":likeFlag])
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "likeExhibition"), object: self, userInfo: ["exhibitionText":exhibitionText, "like":likeFlag])
                
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }

}
