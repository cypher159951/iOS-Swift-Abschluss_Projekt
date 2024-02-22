//
//  ParkingLorryData.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 25.01.24.
//

import Foundation

struct LorryParking: Codable {
    let parkingLorry: [ParkingLorry]

    enum CodingKeys: String, CodingKey {
        case parkingLorry = "parking_lorry"
    }
}

struct ParkingLorry: Codable {
    let extent: String
    let identifier: String
    let routeRecommendation: [String]
    let coordinate: ParkingCoordinate
    let footer: [String]
    let icon: String
    let isBlocked: String // Geändert von Bool zu String
    let description: [String]
    let title: String
    let point: String
    let displayType: String
    let lorryParkingFeatureIcons: [FeatureIcon]
    let future: Bool
    let subtitle: String

    enum CodingKeys: String, CodingKey {
        case extent, identifier, routeRecommendation, coordinate, footer, icon, description, title, point, future, subtitle
        case isBlocked = "isBlocked"
        case displayType = "display_type"
        case lorryParkingFeatureIcons = "lorryParkingFeatureIcons"
    }
}

struct ParkingCoordinate: Codable {
    let lat: String
    let long: String
}

struct FeatureIcon: Codable {
    let icon: String
    let description: String
    let style: String
}
