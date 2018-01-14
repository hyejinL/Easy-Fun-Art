//
//  Docent.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 12..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct Docent: Codable {
    let status: String
    let code: Int
    let message: String
    let data: DocentData
    
    struct DocentData: Codable {
        let ex_state: Int
        let docentDataResult: [DocentPlay.DocentPlayData]
    }
}

