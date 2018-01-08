//
//  ExtensionControl.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum LoadingState {
    case start
    case end
}

extension NSObject{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    func gsno(_ value: String?) -> String {
        if let value_ = value {
            return value_
        } else {
            return ""
        }
    }
    
    func gino(_ value: Int?) -> Int {
        if let value_ = value {
            return value_
        } else {
            return 0
        }
    }
    
    func gfno(_ value: Float?) -> Float {
        if let value_ = value {
            return value_
        } else {
            return 0
        }
    }
    
    func simpleAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func simpleAlert2(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3) {
            alert.dismiss(animated: true)
        }
    }
    
    func loading(_ state: LoadingState) {
        if state == .start {
            CustomLoadingView.shared.startLoading(view)
        } else {
            CustomLoadingView.shared.stopLoading()
        }
    }
    
    // MARK: View Height with Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboard_height = keyboardSize.height
                let centerY = (self.view.frame.height - keyboard_height)/2
                self.view.center.y = centerY
                view.layoutIfNeeded()
//                check = false
            }//if let keyboardSize
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            view.layoutIfNeeded()
//            check = true
        }
    }
}

extension UIImageView {
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
            }
        } else {
            self.image = defaultImg
        }
    }
}
