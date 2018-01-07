//
//  Home.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 7..
//  Copyright © 2018년 hyejin. All rights reserved.
//

struct Home: Codable {
    let status: String
    let code: Int
    let message: String
    let data: HomeData
    
    struct HomeData: Codable {
        let topData: [HomeExhibition]
        let bottomResult: HomeBottomData
        
        struct HomeBottomData: Codable {
            let theme1: [HomeExhibition]
            let theme2: [HomeExhibition]
            let theme3: [HomeExhibition]
        }
    }
}
