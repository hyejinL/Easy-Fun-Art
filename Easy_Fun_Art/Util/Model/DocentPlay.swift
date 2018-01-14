//
//  DocentPlay.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 12..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct DocentPlay: Codable {
    let status: String
    let code: Int
    let message: String
    let data: DocentPlayData
    
    struct DocentPlayData: Codable {
        let ex_id: Int?
        let docent_id: Int?
        let docent_floor: String?
        let docent_title: String
        let docent_track: Int
        let docent_audio: String?
        let docent_text: String?
        let docent_place: String?
    }
}
