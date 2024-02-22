//
//  ElectricChargingStationViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 30.01.24.
//

import Foundation

class ElectricChargingStationViewModel: ObservableObject {
    @Published var electricChargingStations: [ElectricChargingStationData] = []

    init() {
        loadData()
    }

    func loadData() {
        
        updateElectricChargingStations(for: "A1")
    }

    func updateElectricChargingStations(for road: String) {
        Task {
            do {
                let stations = try await fetchElectricChargingStations(for: road)
                DispatchQueue.main.async {
                    self.electricChargingStations = stations
                }
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }

    private func fetchElectricChargingStations(for road: String) async throws -> [ElectricChargingStationData] {
        guard let url = URL(string: "https://verkehr.autobahn.de/o/autobahn/\(road)/services/electric_charging_station") else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ChargingStationsResponse.self, from: data)
        return response.electricChargingStation
    }
}
