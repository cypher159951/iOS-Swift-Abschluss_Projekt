//
//  ClosureData.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 02.02.24.
//

import Foundation

struct ClosureResponse: Codable {
    let closure: [Closure]
}

struct Closure: Codable, Identifiable {
    let id = UUID()
    let extent: String
    let identifier: String
    let routeRecommendation: [String]
    let coordinate: ClosureCoordinate
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

    enum CodingKeys: String, CodingKey {
        case extent, identifier, routeRecommendation, coordinate, footer, icon, isBlocked, description, title, point, displayType, lorryParkingFeatureIcons, future, subtitle, startTimestamp
    }
}

struct ClosureCoordinate: Codable {
    let lat: String
    let long: String
}
