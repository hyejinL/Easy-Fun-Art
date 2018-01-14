//
//  AppDelegate.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import NVActivityIndicatorView
import GoogleMaps
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let playerView = DocentPlayerBarView.instanceFromNib()
    var audioPlayer =  AVPlayer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScalePulseOut
        NVActivityIndicatorView.DEFAULT_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(3.0)
        
        // facebook login 설정
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        GMSServices.provideAPIKey("AIzaSyDyyiuHX4gCu6a9mJg2lVo1IWymIchneKQ")
        
        NotificationCenter.default.addObserver(self, selector: #selector(openPlayerViewController), name: NSNotification.Name(rawValue: "openMusicBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addDocentBar), name: NSNotification.Name(rawValue: "addMusicBar"), object: nil)
        
        return true
    }
    
    @objc func addDocentBar(_ notification: Notification) {
        let window = UIApplication.shared.keyWindow!

        var checkPlayerView:Bool = false
        for subview in window.subviews{
            if subview == playerView{
                checkPlayerView = true
                break
            }
        }
        if checkPlayerView{
            
        }else{
            playerView.frame = CGRect(x: 0, y: (667-99)*UIScreen.main.bounds.height/667, width: UIScreen.main.bounds.width, height: 50*UIScreen.main.bounds.height/667)
            playerView.configure()
            
            window.addSubview(playerView)
            guard let audio = notification.userInfo?["audio"] as? AVPlayer else { return }
            audioPlayer = audio
        }
        
    }

    @objc func openPlayerViewController() {
        if let controller = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: "DocentPlayerViewController") as? DocentPlayerViewController {
            window?.visibleViewController?.present(controller, animated: true, completion: nil)
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options) {
            return true
        } else {
            return false
        }
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}
