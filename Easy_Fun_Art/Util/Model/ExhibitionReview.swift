//
//  ExhibitionReview.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation

struct ExhibitionReview: Codable {
    let status: String
    let code: Int
    let message: String
    let data: ReviewData
    
    struct ReviewData: Codable {
        let reviewGraph: ReviewGraphData
        let latestReview: [Review]
        
        struct ReviewGraphData: Codable {
            let averageGrade: Float
            let totalGradeCount: Int
            let grade_1: Int
            let grade_2: Int
            let grade_3: Int
            let grade_4: Int
            let grade_5: Int
        }
    }
}
