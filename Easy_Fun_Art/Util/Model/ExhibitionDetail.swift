//
//  ExhibitionDetail.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct ExhibitionDetail: Codable {
    let status: String
    let code: Int
    let message: String
    var data: ExhibitionDetailData
    
    struct ExhibitionDetailData: Codable {
        var userInfo: UserInfo
        let exhibition: Exhibition
        let selectedHashtag: [String]
        let unSelectedHashtag: [String]
        let authorResult: AuthorInfo
        
        struct UserInfo: Codable {
            let likeFlag: Int
            var grade: Float
        }
        
        struct Exhibition: Codable {
            let average_grade: Float
            let content: String?
        }
        
        struct AuthorInfo: Codable {
            let author_name: String
            let author_image: String?
            let author_content: String?
        }
    }
}
