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
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    @IBOutlet weak var galleryTitleLabel: UILabel!
    
    var exhibitionID: Int?
    var exhibitionText: String?
    var exhibitonImage: UIImage?
    var galleryText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exhibitionTitleLabel.text = exhibitionText
        exhibitionImageView.image = exhibitonImage
        galleryTitleLabel.text = galleryText
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        docentPopUpView.viewAnimation()
    }
    
    @IBAction func pressedDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goExhibitionDetailView(_ sender: Any) {
        guard let tabBarController = self.presentingViewController as? UITabBarController else { return }
        let navi = tabBarController.viewControllers?[0] as? UINavigationController
        
        self.dismiss(animated: true) {
//            tabBarController.selectedIndex = 2
            let docentPlayListTableViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
            navi?.pushViewController(docentPlayListTableViewController, animated: true)
        }
    }
}
