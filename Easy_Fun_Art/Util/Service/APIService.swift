//
//  APIService.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
//    case failure(Error)
}

protocol APIService {
}

extension APIService {
    func url(_ path: String) -> String {
        return "http://13.125.3.234:3000" + path
    }
    
    func gsno(_ value: String?) -> String {
        if let value_ = value {
            return value_
        } else {
            return ""
        }
    }
    
    func gino(_ value: Int?) -> Int {
        if let value_ = value {
            return value_
        } else {
            return 0
        }
    }
    
    func gfno(_ value: Float?) -> Float {
        if let value_ = value {
            return value_
        } else {
            return 0
        }
    }
}
