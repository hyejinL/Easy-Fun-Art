//
//  UserService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct UserService: APIService {
    static let sharedInstance = UserService()
    
    func userLogin(snsToken: String, completion: @escaping (Result<String>)->Void) {
        let URL = url("/api/login")
        let token = [
            "snsToken" : snsToken
        ]
        
        Alamofire.request(URL, method: .post, parameters: token, encoding: JSONEncoding.default, headers: nil).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    if let status = JSON(value)["status"].string {
                        if status == "success" {
                            guard let token = JSON(value)["data"]["token"].string else { return }
                            completion(.success(token))
                        } else {
                            guard let msg = JSON(value)["msg"].string else { return }
                            completion(.error(msg))
                        }
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
    }
}
