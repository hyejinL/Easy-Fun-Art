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
    let userdefault = UserDefaults.standard
    
    func userLogin(snsToken: String, completion: @escaping (Result<Int>)->Void) {
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
                            guard let token = JSON(value)["data"]["token"].string, let level = JSON(value)["data"]["level"].int else { return }
                            self.userdefault.set(token, forKey: "token")
                            
                            completion(.success(level))
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
    
    func userNicknameCheck(nickname: String, completion: @escaping (Result<Int>)->Void) {
        let URL = url("/api/login/check")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let params = [
            "userNickname" : nickname
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    if let status = JSON(value)["status"].string {
                        if status == "success" {
                            guard let nicknameIsCheck = JSON(value)["data"]["checkFlag"].int else { return }
                            completion(.success(nicknameIsCheck))
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
    
    func sendUserInfo(nickname: String, gender: Int, age: Int, completion: @escaping (Result<Void>)->Void) {
        let URL = url("/api/preference/users")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let body: [String : Any] = [
            "userNickname" : nickname,
            "userSex" : gender,
            "userAge" : age
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    if let status = JSON(value)["status"].string {
                        if status == "success" {
                            self.userdefault.set(gsno(JSON(value)["data"]["token"].string), forKey: "token")
                            
                            completion(.success(()))
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
    
    func sendUserPreference(preGenre: String, prePlace: String, preMood: String, preTopic: String, completion: @escaping (Result<Void>)->Void) {
        let URL = url("/api/preference")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let body: [String : String] = [
            "prePlace" : prePlace,
            "preMood" : preMood,
            "preGenre" : preGenre,
            "preSubject" : preTopic
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    if let status = JSON(value)["status"].string {
                        if status == "success" {
                            self.userdefault.set(gsno(JSON(value)["data"]["token"].string), forKey: "token")
                            completion(.success(()))
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
