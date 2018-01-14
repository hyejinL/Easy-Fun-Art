//
//  SearchList.swift
//  Easy_Fun_Art
//
//  Created by KanghoonOh on 2018. 1. 13..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct SearchList: Decodable {
    let status: String
    let code: Int
    let message: String
    let data: Data
    
    struct Data:Decodable {
        let searchData: [SearchData]
    }
    
    struct SearchData: Decodable {
        let ex_id: Int
        let ex_image: String
        let ex_author_name: String
        let ex_title: String
        let ex_start_date: String
        let ex_end_date: String
        let gallery_name: String
        let ex_average_grade: Float
        let likeFlag: Int
    }
    
}

