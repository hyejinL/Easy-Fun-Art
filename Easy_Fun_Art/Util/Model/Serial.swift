//
//  Serial.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 13..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct Serial: Codable {
    let status: String
    let code: Int
    let message: String
    let data: SerialData
    
    struct SerialData: Codable {
        let serialData: AudioData
        
        struct AudioData: Codable {
            let ex_id: Int
            let ex_serial_num: String
            let ex_title: String
            let ex_start_date: String
            let ex_end_date: String
            let ex_image: String?
            let ex_average_grade: Float
            let gallery_id: Int
            let theme_id: Int
        }
    }
}
