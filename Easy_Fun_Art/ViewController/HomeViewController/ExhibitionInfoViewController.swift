//
//  ExhibitionInfoViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 5..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import RAMAnimatedTabBarController

class ExhibitionInfoViewController: SJSegmentedViewController {
    var selectedSegment:SJSegmentTab?
    
    override func viewDidLoad() {
        

        let storyboard = UIStoryboard(name: "Docent", bundle: nil)
        
        let exhibitionHeaderViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoHeaderViewController.reuseIdentifier) as! ExhibitionInfoHeaderViewController
        
        let firstViewController = storyboard.instantiateViewController(withIdentifier: DocentAroundTableViewController.reuseIdentifier) as! DocentAroundTableViewController
        firstViewController.title = "전시정보"
        
        let secondViewController = storyboard.instantiateViewController(withIdentifier: DocentAroundTableViewController.reuseIdentifier) as! DocentAroundTableViewController
        secondViewController.title = "갤러리정보"
        
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: DocentAroundTableViewController.reuseIdentifier) as! DocentAroundTableViewController
        thirdViewController.title = "리뷰"
        
        segmentControllers = [firstViewController, secondViewController, thirdViewController]
        headerViewController = exhibitionHeaderViewController
        segmentViewHeight = 40
        selectedSegmentViewHeight = 2.0
        segmentTitleColor = #colorLiteral(red: 0.3234693706, green: 0.3234777451, blue: 0.3234732151, alpha: 1)
        selectedSegmentViewColor = #colorLiteral(red: 0.9926154017, green: 0.8786800504, blue: 0, alpha: 1)
        segmentShadow = SJShadow.init(offset: CGSize(width: 0, height: 1.0), color: #colorLiteral(red: 0.8861932158, green: 0.8862140179, blue: 0.8862028718, alpha: 1), radius: 1.0, opacity: 0.4)
//        segmentShadow = SJShadow.light()
        
        delegate = self
        headerViewHeight = 302
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        let view = UIImageView()
        view.frame.size.width = 100
        view.frame.size.height = 0
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        self.navigationItem.titleView = view
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.navigationBar.isHidden = false
        
        segmentedScrollView.delegate = self
        
        self.view.layoutIfNeeded()
//        self.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let animatedTabBar = self.tabBarController as? RAMAnimatedTabBarController else { return }
        animatedTabBar.animationTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isHidden = true
        
        guard let animatedTabBar = self.tabBarController as? RAMAnimatedTabBarController else { return }
        animatedTabBar.animationTabBarHidden(false)
    }

}

extension ExhibitionInfoViewController: SJSegmentedViewControllerDelegate {
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        if selectedSegment != nil {
            selectedSegment?.titleColor(#colorLiteral(red: 0.3234693706, green: 0.3234777451, blue: 0.3234732151, alpha: 1))
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(#colorLiteral(red: 0.3234693706, green: 0.3234777451, blue: 0.3234732151, alpha: 1))
        }
    }
}

extension ExhibitionInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 200 {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
        self.navigationController?.navigationBar.alpha = 1.0-(309-scrollView.contentOffset.y)/309
        
    }
}

