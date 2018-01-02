//
//  SplashViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class SplashViewController: UIViewController {

    @IBOutlet weak var backgroundLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var facebookStartButton: UIButton!
    @IBOutlet weak var kakaotalkStartButton: UIButton!
    
    var fbData: UserDataRequest.Response?
    
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
//        let tabbarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
//        self.present(tabbarViewController, animated: true, completion: nil)
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                self.getFacebookUserData()
                
                let tabbarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
                self.present(tabbarViewController, animated: true, completion: nil)

                break
            case .failed(let err as NSError):
                print(err.localizedDescription)
                break
            case .cancelled:
                print("페북 로그인 취소")
                break
            }
        }
    }
    
    @IBAction func pressedKakaoStart(_ sender: Any) {
        let tabbarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
        self.present(tabbarViewController, animated: true, completion: nil)
    }
    
    func splashAnimation() {
        UIView.animate(withDuration: 4.5) {
            self.backgroundLeadingConstant.isActive = false
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.8) {
            self.facebookStartButton.isHidden = false; self.kakaotalkStartButton.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.facebookStartButton.alpha = 1; self.kakaotalkStartButton.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func getFacebookUserData() {
        
        let connection = GraphRequestConnection()
        
        connection.add(UserDataRequest()) {
            (response: HTTPURLResponse?, result: GraphRequestResult<UserDataRequest>) in
            switch result {
            case .success(let graphResponse):
                self.fbData = graphResponse
                print(graphResponse.email, graphResponse.id, graphResponse.name, graphResponse.profileURL)
                break
            case .failed :
                break
            }
        }
        connection.start()
    }

}
