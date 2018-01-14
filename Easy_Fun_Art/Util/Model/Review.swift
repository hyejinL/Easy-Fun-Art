//
//  Review.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct Review: Codable {
    let review_id: Int
    let review_date: String
    let review_grade: Int
    let review_watch_date: String
    let user_id: Int
    let review_content: String?
    let review_image: String?
    let user_nickname: String
    let user_profile: String?
}

