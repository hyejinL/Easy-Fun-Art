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
    
    func myPageUpdate(completion: @escaping (Result<User.UserData>)->Void) {
        let URL = url("/api/mypage")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let mypageData = try decoder.decode(User.self, from: value)
                        print(mypageData)
                        if mypageData.status == "success" {
                            completion(.success(mypageData.data))
                        } else {
                            completion(.error(mypageData.code))
                        }
                    } catch {
                        guard let code = JSON(value)["code"].int else { return }
                        completion(.error(code))
                    }
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(err))
                break
            }
        }
    }
}
