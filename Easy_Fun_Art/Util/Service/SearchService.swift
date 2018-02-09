//
//  SearchService.swift
//  Easy_Fun_Art
//
//  Created by KanghoonOh on 2018. 1. 13..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SearchService: APIService {
    let userdefault = UserDefaults.standard
    static let shareInstance = SearchService()
    
    func search(qString: String, period:Int, order: Int, completion: @escaping (Result<[SearchList.SearchData]>)->Void) {
        let URL = url("/api/search")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let params = [
            "qString" : qString,
            "period" : period,
            "order" : order
            ] as [String : Any]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do{
                        let decoder = JSONDecoder()
                        let searchList = try decoder.decode(SearchList.self, from: value)
                        if searchList.status == "success"{
                            completion(.success(searchList.data.searchData))
                        }else{
                            completion(.error(searchList.code))
                        }
                    }catch{
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

