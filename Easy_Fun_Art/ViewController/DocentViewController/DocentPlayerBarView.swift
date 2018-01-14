//
//  DocentPlayerBarView.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 8..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class DocentPlayerBarView: UIView {

    class func instanceFromNib() -> DocentPlayerBarView {
        return UINib(nibName: DocentPlayerBarView.reuseIdentifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DocentPlayerBarView
    }
    
    func configure(){
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(openDocentViewController))
        self.addGestureRecognizer(backgroundTap)
    }
    
    @objc func openDocentViewController() {
        print("ffff")
        self.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openMusicBar"), object: self)
    }

    

}
