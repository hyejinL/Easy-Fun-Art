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
    var exhibitionImageURL: String?
    var galleryText: String?
    var galleryId = -1
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exhibitionTitleLabel.text = exhibitionText
        if exhibitonImage == nil {
            exhibitionImageView.imageFromUrl(gsno(exhibitionImageURL), defaultImgPath: "1")
        } else {
            exhibitionImageView.image = exhibitonImage
        }
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
        print(1111)
//        guard let tabBarController = self.presentingViewController as? UITabBarController else { return }
//        let navi = tabBarController.viewControllers?[0] as? UINavigationController
        
//        self.dismiss(animated: true) {
//            print(2222)
//            //            tabBarController.selectedIndex = 2
//            let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
//
//            exhibitionInfoViewController.id = self.gino(self.exhibitionID)
//            exhibitionInfoViewController.exhibitionTitle = self.exhibitionText
////            exhibitionInfoViewController.gallery = self.galleryText
//            exhibitionInfoViewController.galleryId = self.galleryId
//            exhibitionInfoViewController.image = self.exhibitionImageView.image
//
//            navi?.pushViewController(exhibitionInfoViewController, animated: true)
//        }
        let navi = self.presentingViewController as? UINavigationController
        self.dismiss(animated: true) {
            let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
            
            exhibitionInfoViewController.id = self.gino(self.exhibitionID)
            exhibitionInfoViewController.exhibitionTitle = self.exhibitionText
            //            exhibitionInfoViewController.gallery = self.galleryText
            exhibitionInfoViewController.galleryId = self.galleryId
            exhibitionInfoViewController.image = self.exhibitionImageView.image

            navi?.pushViewController(exhibitionInfoViewController, animated: true)
        }
    }
    
    @IBAction func goAudioGuideView(_ sender: Any) {
//        guard let tabBarController = self.presentingViewController as? UITabBarController else { return }
//        let navi = tabBarController.viewControllers?[0] as? UINavigationController
        
        let navi = self.presentingViewController as? UINavigationController
        self.dismiss(animated: true) {
            //            tabBarController.selectedIndex = 2
            let docentPlayListTableViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
            
            docentPlayListTableViewController.exhibitionId = self.gino(self.exhibitionID)
            docentPlayListTableViewController.exhibitionTitle = self.exhibitionTitleLabel.text
            docentPlayListTableViewController.exhibitionImage = self.exhibitionImageURL
            
            navi?.pushViewController(docentPlayListTableViewController, animated: true)
        }
    }
}
