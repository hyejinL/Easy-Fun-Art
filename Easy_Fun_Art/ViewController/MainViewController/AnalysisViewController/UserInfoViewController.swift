//
//  UserInfoViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let genreCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GenreCheckViewController.reuseIdentifier) as! GenreCheckViewController
        
        self.navigationController?.pushViewController(genreCheckViewController, animated: true)
    }
}
