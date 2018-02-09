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
    
    func docentList(exhibitionId: Int, completion: @escaping (Result<Docent.DocentData>)->Void) {
        let URL = url("/api/playlist/guide")
        let params = [
            "exId" : exhibitionId
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: nil).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    print(value)
                    do {
                        let decoder = JSONDecoder()
                        let playListData = try decoder.decode(Docent.self, from: value)
                        if playListData.status == "success" {
                            completion(.success(playListData.data))
                        } else {
                            completion(.error(playListData.code))
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
    
    func docentPlay(exhibitionId: Int, docentTrack: Int, completion: @escaping (Result<DocentPlay.DocentPlayData>)->Void) {
        let URL = url("/api/docent")
        let params = [
            "exId" : exhibitionId,
            "docentTrack" : docentTrack
        ]
        
        Alamofire.request(URL, method: .get, parameters: params, headers: nil).responseData() { res in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    do {
                        let decoder = JSONDecoder()
                        let docentPlayData = try decoder.decode(DocentPlay.self, from: value)
                        if docentPlayData.status == "success" {
                            completion(.success(docentPlayData.data))
                        } else {
                            completion(.error(docentPlayData.code))
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
