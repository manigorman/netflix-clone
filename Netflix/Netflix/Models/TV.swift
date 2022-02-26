//
//  TV.swift
//  Netflix
//
//  Created by Igor Manakov on 26.02.2022.
//

import Foundation

struct TrendingTVsResponse: Codable {
    let results: [TV]
}

struct TV: Codable {
    let id: Int
    let media_type: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
