//
//  DocentPlayerBarView.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 8..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class DocentPlayerBarView: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: DocentPlayerBarView.reuseIdentifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    

}
