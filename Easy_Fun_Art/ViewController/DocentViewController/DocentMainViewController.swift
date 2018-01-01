//
//  DocentMainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DocentMainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        barPagerSetting()
        self.title = "도슨트"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let aroundMeViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentAroundTableViewController.reuseIdentifier) as! DocentAroundTableViewController
        let myExhibitionViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentMyTableViewController.reuseIdentifier) as! DocentMyTableViewController
        return [aroundMeViewController, myExhibitionViewController]
    }
    
    func barPagerSetting() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.9926154017, green: 0.8786800504, blue: 0, alpha: 1)
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15.0)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0.9926154017, green: 0.8786800504, blue: 0, alpha: 1)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = #colorLiteral(red: 0.1930259168, green: 0.1930313706, blue: 0.19302845, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 0.1930259168, green: 0.1930313706, blue: 0.19302845, alpha: 1)
        }
        self.tabBarController?.tabBar.unselectedItemTintColor = .clear
    }

}
