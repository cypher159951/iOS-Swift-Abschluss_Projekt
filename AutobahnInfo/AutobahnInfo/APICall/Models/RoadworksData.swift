//
//  RoadworksData.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation

struct RoadworksData: Codable {
    let roadworks: [Roadwork]
}



struct Roadwork: Codable, Hashable {
    let extent: String
    let identifier: String
    let routeRecommendation: [String]
    let coordinate: Coordinate
    let footer: [String]
    let icon: String
    let isBlocked: String
    let description: [String]
    let title: String
    let point: String
    let displayType: String?
    let lorryParkingFeatureIcons: [String]
    let future: Bool
    let subtitle: String
    let startTimestamp: String
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

        static func ==(lhs: Roadwork, rhs: Roadwork) -> Bool {
            lhs.identifier == rhs.identifier
        }
    }

struct Coordinate: Codable {
    let lat: String
    let long: String
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(lat)
            hasher.combine(long)
        }
}
