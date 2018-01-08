//
//  MainPopUpViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MainPopUpViewController: UIViewController {

    @IBOutlet weak var docentPopUpView: UIView!
    @IBOutlet weak var exhibitionImageView: UIImageView!
    
//    var 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exhibitionImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        exhibitionImageView.contentMode = .scaleAspectFill // OR .scaleAspectFill
        exhibitionImageView.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        docentPopUpView.viewAnimation()
    }
    
    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goExhibitionDetailView(_ sender: Any) {
        
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        let navi = self.presentingViewController as? UINavigationController
        
        self.dismiss(animated: true) {
            navi?.pushViewController(exhibitionInfoViewController, animated: true)
        }
    }
}
