//
//  LikeViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class LikeViewController: UIViewController {
    
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    
    var exhibitionText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exhibitionTitleLabel.text = exhibitionText

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
