//
//  SplashViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var backgroundLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var facebookStartButton: UIButton!
    @IBOutlet weak var kakaotalkStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookStartButton.alpha = 0; facebookStartButton.isHidden = true
        kakaotalkStartButton.alpha = 0; kakaotalkStartButton.isHidden = true
        splashAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFacebookStart(_ sender: Any) {
        let tabbarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
        self.present(tabbarViewController, animated: true, completion: nil)
    }
    
    func splashAnimation() {
        UIView.animate(withDuration: 4.5) {
            self.backgroundLeadingConstant.isActive = false
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.facebookStartButton.isHidden = false; self.kakaotalkStartButton.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.facebookStartButton.alpha = 1; self.kakaotalkStartButton.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
