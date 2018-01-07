//
//  HomeService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 7..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HomeService: APIService {
    static let shareInstance = HomeService()
    let userdefault = UserDefaults.standard
    
    func mainInfo(completion: @escaping (Result<Home.HomeData>)->Void) {
        let URL = url("/api/home")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    print(JSON(value))
                    let decoder = JSONDecoder()
                    do {
                        let homeData = try decoder.decode(Home.self, from: value)
                        if homeData.status == "succes" {
                            completion(.success(homeData.data))
                        } else {
                            completion(.error(homeData.message))
                        }
                    } catch {
                        guard let msg = JSON(value)["status"].string else { return }
                        completion(.error(msg))
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
