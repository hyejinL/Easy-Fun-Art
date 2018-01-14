//
//  User.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct User: Codable {
    let status: String
    let code: Int
    let message: String
    let data: UserData
 
    struct UserData: Codable {
        let user_data: UserInfo
        let user_Like_Count: Int
        let user_Review_Count: Int
        let user_Grade_Count: Int
        let user_Like_List: [UserLikeData]
        let user_Review_List: [UserReviewData]
        
        struct UserInfo: Codable {
            let user_nickname: String
            let user_profile: String?
            let user_place: [Int]
            let user_genre: [Int]
            let user_mood: [Int]
            let user_subject: [Int]
        }
        
        struct UserLikeData: Codable {
            let ex_id: Int
            let ex_title: String
            let ex_image: String?
        }
        
        struct UserReviewData: Codable {
            let user_nickname: String
            let review_grade: Int
            let review_content: String
            let review_date: String
            let review_watch_date: String
            let review_image: String?
            let ex_title: String
        }
    }
}
