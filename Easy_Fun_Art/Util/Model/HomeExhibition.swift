//
//  HomeExhibition.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 7..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct HomeExhibition: Codable {
    let theme_title: String?
    let ex_id: Int
    let ex_title: String
    let ex_image: String?
    let ex_start_date: String?
    let ex_end_date: String?
    let ex_average_grade: Float
    let gallery_id: Int
    let gallery_name: String?
    let likeFlag: Int?
}
