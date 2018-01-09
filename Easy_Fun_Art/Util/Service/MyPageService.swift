//
//  MyPageService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 9..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MyPageService: APIService {
    static let shareInstance = MyPageService()
    let userdefault = UserDefaults.standard
    
    func myPageUpdate(completion: @escaping (Result<String>)->Void) {
        let URL = url("/api/mypage")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        
    }
}
