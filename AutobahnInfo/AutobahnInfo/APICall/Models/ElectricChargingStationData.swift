//
//  ElectricChargingStation.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 30.01.24.
//

struct ElectricChargingStationData: Codable, Hashable {
    var identifier: String
    var coordinate: Coordinate
    var title: String
    var subtitle: String
    var isBlocked: Bool
    var displayType: String?
    var description: [String]

    struct Coordinate: Codable, Hashable {
        var lat: String
        var long: String

        enum CodingKeys: String, CodingKey {
            case lat
            case long
        }
    }

    enum CodingKeys: String, CodingKey {
        case identifier
        case coordinate
        case title
        case subtitle
        case isBlocked = "isBlocked"
        case displayType
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coordinateContainer = try container.nestedContainer(keyedBy: Coordinate.CodingKeys.self, forKey: .coordinate)

        identifier = try container.decode(String.self, forKey: .identifier)
        let lat = try coordinateContainer.decode(String.self, forKey: .lat)
        let long = try coordinateContainer.decode(String.self, forKey: .long)
        coordinate = Coordinate(lat: lat, long: long)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        
        let isBlockedString = try container.decode(String.self, forKey: .isBlocked)
        isBlocked = isBlockedString.lowercased() == "true"
        
        displayType = try container.decodeIfPresent(String.self, forKey: .displayType)
        description = try container.decode([String].self, forKey: .description)
    }
}
