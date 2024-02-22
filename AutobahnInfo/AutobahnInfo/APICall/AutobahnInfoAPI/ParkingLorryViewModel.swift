//
//  ParkingLorryViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 25.01.24.
//


import Foundation

class ParkingLorryViewModel: ObservableObject {
    @Published var roadsData: LorryParking?

    func updateParkingLorryData(for road: String) {
        Task {
            do {
                let roadsData = try await fetchRoadList(for: road)
                DispatchQueue.main.async {
                    self.roadsData = roadsData
                }
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }

    private func fetchRoadList(for road: String) async throws -> LorryParking {
        guard let url = URL(string: "https://verkehr.autobahn.de/o/autobahn/\(road)/services/parking_lorry") else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(LorryParking.self, from: data)
    }
}

