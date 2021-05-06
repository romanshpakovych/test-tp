//
//  LandmarkEntity.swift
//  Runner
//
//  Created by Vladimir on 06.05.2021.
//

import Foundation

struct LandmarkEntity: Codable {
    let likelihood: Float
    let type: String
    let coordinates: CoordinatesEntity
}
