//
//  UIExtension.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 2..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func buttonAnimation() {
        UIView.animate(withDuration: 0.13, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion:{ _ in
            UIView.animate(withDuration: 0.13, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
}
