//
//  NicknameChangeViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class NicknameChangeViewController: UIViewController {

    @IBOutlet weak var nicknameSettingTextField: UITextField!
    @IBOutlet weak var nicknameSettingErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissChangeNickname(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
