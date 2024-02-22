//
//  ChargingStationsResponse.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 30.01.24.
//

import Foundation

struct ChargingStationsResponse: Codable {
    var electricChargingStation: [ElectricChargingStationData]

    enum CodingKeys: String, CodingKey {
        case electricChargingStation = "electric_charging_station"
    }
}
