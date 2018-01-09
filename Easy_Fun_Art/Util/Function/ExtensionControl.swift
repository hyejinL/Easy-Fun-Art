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

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
