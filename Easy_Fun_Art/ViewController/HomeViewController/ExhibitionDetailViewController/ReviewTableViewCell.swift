//
//  ReviewTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewWriteButton: UIButton!
    @IBOutlet weak var ratingScoreLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingView1: UIView!
    @IBOutlet weak var ratingView2: UIView!
    @IBOutlet weak var ratingView3: UIView!
    @IBOutlet weak var ratingView4: UIView!
    @IBOutlet weak var ratingView5: UIView!
    @IBOutlet weak var ratingView1Width: NSLayoutConstraint!
    @IBOutlet weak var ratingView2Width: NSLayoutConstraint!
    @IBOutlet weak var ratingView3Width: NSLayoutConstraint!
    @IBOutlet weak var ratingView4Width: NSLayoutConstraint!
    @IBOutlet weak var ratingView5Width: NSLayoutConstraint!
    
    var ratingView = [UIView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configure(count: Int, rating: [Rating]) {
        ratingView = [ratingView5, ratingView4, ratingView3, ratingView2, ratingView1]
        
        print(count)
        if count > 0 {
            let sortedRating = rating.sorted { $0.count > $1.count }
            print(sortedRating)
            
            ratingView[sortedRating[0].rating-1].backgroundColor = #colorLiteral(red: 0.660695672, green: 0.6607115269, blue: 0.6607030034, alpha: 1)
            ratingView[sortedRating[1].rating-1].backgroundColor = #colorLiteral(red: 0.7472794652, green: 0.7472972274, blue: 0.7472876906, alpha: 1)
            ratingView[sortedRating[2].rating-1].backgroundColor = #colorLiteral(red: 0.8341351151, green: 0.8341547251, blue: 0.8341441751, alpha: 1)
            ratingView[sortedRating[3].rating-1].backgroundColor = #colorLiteral(red: 0.9150560498, green: 0.9150775075, blue: 0.9150659442, alpha: 1)
            ratingView[sortedRating[4].rating-1].backgroundColor = #colorLiteral(red: 0.9150560498, green: 0.9150775075, blue: 0.9150659442, alpha: 1)
            
            for element in sortedRating {
                
                switch element.rating {
                case 5:
                    ratingView1Width.constant = (CGFloat(element.count)/CGFloat(count))*98.0
                    break
                case 4:
                    ratingView2Width.constant = (CGFloat(element.count)/CGFloat(count))*98.0
                    break
                case 3:
                    ratingView3Width.constant = (CGFloat(element.count)/CGFloat(count))*98.0
                    break
                case 2:
                    ratingView4Width.constant = (CGFloat(element.count)/CGFloat(count))*98.0
                    break
                case 1:
                    ratingView5Width.constant = (CGFloat(element.count)/CGFloat(count))*98.0
                    break
                default:
                    break
                }
            }
        }
    }
    
}
