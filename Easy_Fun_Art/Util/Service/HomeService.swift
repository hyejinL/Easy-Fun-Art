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
                            completion(.error(homeData.code))
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
    
    func likeExhibition(exhibitionId: Int, completion: @escaping (Result<Int>)->Void) {
        let URL = url("/api/home/like")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let params = [
            "exId" : exhibitionId
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    if let status = JSON(value)["status"].string {
                        if status == "success" {
                            guard let likeFlag = JSON(value)["data"]["likeFlag"].int else { return }
                            completion(.success(likeFlag))
                        } else {
                            guard let code = JSON(value)["code"].int else { return }
                            completion(.error(code))
                        }
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
    
    func exhibitionDetail(exhibitionId: Int, completion: @escaping (Result<ExhibitionDetail.ExhibitionDetailData>)->Void) {
        let URL = url("/api/exhibition/\(exhibitionId)/info")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let exhibitionData = try decoder.decode(ExhibitionDetail.self, from: value)
                        if exhibitionData.status == "success" {
                            completion(.success(exhibitionData.data))
                        } else {
                            completion(.error(exhibitionData.code))
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
    
    func galleryDetail(galleryId: Int, completion: @escaping (Result<GalleryDetail.GalleryDetailData>)->Void) {
        let URL = url("/api/gallery/\(galleryId)/info")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let galleryData = try decoder.decode(GalleryDetail.self, from: value)
                        if galleryData.status == "success" {
                            completion(.success(galleryData.data))
                        } else {
                            completion(.error(galleryData.code))
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
    
    func exhibitionReview(exhibitionId: Int, completion: @escaping (Result<ExhibitionReview.ReviewData>)->Void) {
        let URL = url("/api/exhibition/\(exhibitionId)/review")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let reviewData = try decoder.decode(ExhibitionReview.self, from: value)
                        if reviewData.status == "success" {
                            completion(.success(reviewData.data))
                        } else {
                            completion(.error(reviewData.code))
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
    
    func sendMyRate(exhibitionid: Int, reviewGrade: Float, completion: @escaping (Result<Void>)->Void) {
        let URL = url("/api/home/scoregrade?exId=\(exhibitionid)")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let body: [String:Any] = [
            "reviewGrade" : reviewGrade
        ]
     
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    guard let status = JSON(value)["status"].string else { return }
                    if status == "success" {
                        completion(.success(()))
                    } else {
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
    
//    func searchDocentSerial(serialNumber: String, completion: @escaping (Result<String>)->Void) {
//        let URL = url("/api/home/serial?serial_num=\(serialNumber)")
//        let token = [
//            "user_token" : gsno(userdefault.string(forKey: "token"))
//        ]
//
//        Alamofire.request(URL, method: .get, parameters: nil, headers: token).responseData() { res in
//            switch res.result {
//            case .success:
//                if let value = res.result.value {
//                    do {
//                        let decoder = JSONDecoder()
//                        let serialInfo = try decoder.decode(Serial.self, from: value)
//                        if serialInfo.status == "success" {
//
//                        } else {
//                            completion(.error(seriaInfo))
//                        }
//                    }
//                }
//                break
//            case .failure(let err):
//                print(err.localizedDescription)
//                break
//            }
//        }
//    }
    
    func searchDocentSerial(serialNumber: String, completion: @escaping (Result<Serial.SerialData.AudioData>)->Void) {
        let URL = url("/api/home/serial")
        let token = [
            "user_token" : gsno(userdefault.string(forKey: "token"))
        ]
        let params = [
            "serial_num" : serialNumber
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: token).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let serialData = try decoder.decode(Serial.self, from: value)
                        if serialData.status == "success" {
                            completion(.success(serialData.data.serialData))
                        } else {
                            completion(.error(serialData.code))
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
