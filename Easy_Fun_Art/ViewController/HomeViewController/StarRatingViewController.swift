//
//  StarRatingViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class StarRatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pressedConfirmRatingButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
