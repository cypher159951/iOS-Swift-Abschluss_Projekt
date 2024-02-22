//
//  WarningService.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 31.01.24.
//

import Foundation

// Hauptstruktur für die Antwort
struct TrafficWarningResponse: Codable {
    let warnings: [Warning]
    
    enum CodingKeys: String, CodingKey {
            case warnings = "warning"
        }
}

// Struktur für jede Warnung
struct Warning: Codable {
    let extent: String
    let identifier: String
    let routeRecommendation: [String]
    let coordinate: TrafficWarningCoordinate
    let icon: String
    let isBlocked: String
    let description: [String]
    let title: String
    let point: String
    let displayType: String
    let lorryParkingFeatureIcons: [String]
    let future: Bool
    let subtitle: String
    let startTimestamp: String

    enum CodingKeys: String, CodingKey {
        case extent, identifier, routeRecommendation, coordinate, icon, isBlocked, description, title, point, lorryParkingFeatureIcons, future, subtitle, startTimestamp
        case displayType = "display_type"
    }
}

// Struktur für Koordinaten
struct TrafficWarningCoordinate: Codable {
    let lat: String
    let long: String
}
