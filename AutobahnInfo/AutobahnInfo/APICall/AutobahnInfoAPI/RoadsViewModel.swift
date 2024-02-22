//
//  AutobahnInfoAPIViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation

class RoadsViewModel: ObservableObject {
    @Published var roadsData = RoadsData(roads: [])

    init() {
        fetchRoadsData()
    }

    private func fetchRoadList() async throws -> RoadsData {
        guard let url = URL(string: "https://verkehr.autobahn.de/o/autobahn/") else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let roadsResponse = try JSONDecoder().decode(RoadsData.self, from: data)

        // Daten auf dem Hauptthread veröffentlichen
        DispatchQueue.main.async {
            self.roadsData = roadsResponse
        }
       

        return roadsResponse
    }

    func fetchRoadsData() {
        Task {
            do {
                _ = try await fetchRoadList()
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
}
