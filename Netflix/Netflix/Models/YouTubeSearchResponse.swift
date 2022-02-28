//
//  YouTubeSearchResponse.swift
//  Netflix
//
//  Created by Igor Manakov on 28.02.2022.
//

import Foundation

struct YouTubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
