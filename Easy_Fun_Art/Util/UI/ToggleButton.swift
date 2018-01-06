//
//  ToggleButton.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

class ToggleButton : UIButton {
    @IBInspectable var trueImage: UIImage?
    @IBInspectable var falseImage: UIImage?
    
    var title: String = ""
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                setImage(trueImage, for: .normal)
            } else {
                setImage(falseImage, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed (sender: UIButton) {
        isChecked = !isChecked
        sender.buttonAnimation()
    }
}
