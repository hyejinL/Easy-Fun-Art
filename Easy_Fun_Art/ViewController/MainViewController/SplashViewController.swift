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
    let userdefault = UserDefaults.standard
    
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
        loading(.start)
        
        if (FBSDKAccessToken.current()) != nil {
            getFacebookUserData()
        } else {
            let loginManager = LoginManager()
            
            loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (loginResult) in
                switch loginResult {
                case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                    self.getFacebookUserData()
                    
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
                self.userdefault.set("facebook", forKey: "loginType")
                self.loginAction(graphResponse: graphResponse)
                break
            case .failed :
                break
            }
        }
        connection.start()
    }
    
    func loginAction(graphResponse: UserDataRequest.Response) {
        UserService.sharedInstance.userLogin(snsToken: graphResponse.id) { (result) in
            switch result {
            case .success(let level):
                if level == 10 {
                    let analysisStartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartNavi") as! UINavigationController
                    self.present(analysisStartViewController, animated: true, completion: {
                        self.loading(.end)
                    })
                } else if level == 20 {
                    let genreCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GenreCheckViewController.reuseIdentifier) as! GenreCheckViewController
                    self.present(genreCheckViewController, animated: true, completion: {
                        self.loading(.end)
                    })
                } else if level == 50 {
                    let tabbarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
                    self.present(tabbarViewController, animated: true, completion: {
                        self.loading(.end)
                    })
                }
                
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }

}
