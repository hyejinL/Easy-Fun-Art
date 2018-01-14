//
//  StarRatingViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import Cosmos

class StarRatingViewController: UIViewController {

    @IBOutlet weak var myRating: CosmosView!
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    
    var exhibitionId = -1
    var exhibitionText: String?
    var myRate = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myRating.rating = Double(myRate)
        exhibitionTitleLabel.text = exhibitionText
    }

    @IBAction func pressedConfirmRatingButton(_ sender: Any) {
        sendMyRating()
    }
    
    func sendMyRating() {
        HomeService.shareInstance.sendMyRate(exhibitionid: exhibitionId, reviewGrade: Float(myRating.rating)) { (result) in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "myRatingSetting"), object: self, userInfo: ["rating":Float(self.myRating.rating)])
                self.dismiss(animated: true, completion: nil)
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
}
