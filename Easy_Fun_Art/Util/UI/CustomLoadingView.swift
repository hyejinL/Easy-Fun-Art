//
//  CustomLoadingView.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 7..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

open class CustomLoadingView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    open class var shared: CustomLoadingView {
        struct Static {
            static let instance: CustomLoadingView = CustomLoadingView()
        }
        return Static.instance
    }
    
    open func startLoading(_ view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.62)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(white: 0xffffff, alpha: 0)
        progressView.clipsToBounds = true
        progressView.layer.shadowColor = UIColor.black.cgColor
        progressView.layer.shadowOffset = CGSize.zero
        progressView.layer.shadowOpacity = 1
        progressView.layer.shadowRadius = 10
        progressView.layer.cornerRadius = 10
        
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func stopLoading() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    
}
