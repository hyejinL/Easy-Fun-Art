//
//  DocentService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 8..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DocentService: APIService {
    static let shareInstance = DocentService()
    let userdefault = UserDefaults.standard
    
    func locationExhibitionList(latitude: Float, longitude: Float, completion: @escaping (Result<[HomeExhibition]>)->Void) {
        let URL = url("/api/playlist/site")
        let params = [
            "latitude" : latitude,
            "longitude" : longitude
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: nil).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let playListSuccess = try decoder.decode(PlayList.self, from: value)
                        completion(.success(playListSuccess.data))
                    } catch {
                        guard let msg = JSON(value)["msg"].string else { return }
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
    
    func likeExhibitionList(completion: @escaping (Result<[HomeExhibition]>)->Void) {
        let URL = url("/api/playlist/favor")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let playListSuccess = try decoder.decode(PlayList.self, from: value)
                        completion(.success(playListSuccess.data))
                    } catch {
                        guard let msg = JSON(value)["msg"].string else { return }
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
