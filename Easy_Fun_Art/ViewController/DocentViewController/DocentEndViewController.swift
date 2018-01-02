//
//  DocentEndViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 2..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class DocentEndViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressedRefuseReview(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
