//
//  MyPageMainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MyPageMainViewController: UIViewController {

    @IBOutlet weak var myProfileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func profileChangeButton(_ sender: Any) {
    }
}
