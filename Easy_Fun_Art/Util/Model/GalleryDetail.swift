//
//  GalleryDetail.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct GalleryDetail: Codable {
    let status: String
    let code: Int
    let message: String
    let data: GalleryDetailData
    
    struct GalleryDetailData: Codable {
//        let period: String
        let runtime: String
        let address: String
        let phone: String
        let latitude: Double
        let longitude: Double
    }
}
