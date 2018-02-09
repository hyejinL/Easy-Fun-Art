//
//  RecommendService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 12..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RecommendService: APIService {
    static let shareInstance = RecommendService()
    let userdefault = UserDefaults.standard
    
    func RecommendData(completion: @escaping (Result<[HomeExhibition]>)->Void) {
        let URL = url("/api/recommend")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let recommendData = try decoder.decode(Recommend.self, from: value)
                        if recommendData.status == "success" {
                            completion(.success(recommendData.data))
                        } else {
                            completion(.error(recommendData.code))
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
