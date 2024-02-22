//
//  Roadworks.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 23.01.24.
//

import Foundation

class RoadworksViewModel: ObservableObject {
    @Published var roadworks = [Roadwork]()
    
    
    init() {
        fetchRoadsworksData(for: "A2")
    }
    
    private func fetchRoadworks(for road: String) async throws -> [Roadwork] {
        let urlString = "https://verkehr.autobahn.de/o/autobahn/\(road)/services/roadworks"
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let roadworksResponse = try JSONDecoder().decode(RoadworksData.self, from: data)
        print("Daten wurden Decodiert")
        return roadworksResponse.roadworks
    }
    
    func fetchRoadsworksData(for road: String) {
        Task {
            do {
                let roadworksResponse = try await fetchRoadworks(for: road)
                DispatchQueue.main.async {
                    self.roadworks = roadworksResponse
                //    print("Erfolgreich Roadworks-Daten für \(road) geladen: \(self.roadworks)")
                }
            } catch {
                DispatchQueue.main.async {
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
    func roadworkInfo(for road: String) async -> [Roadwork]? {
            do {
                return try await fetchRoadworks(for: road)
            } catch {
                print("Fehler beim Laden der Roadwork-Informationen: \(error)")
                return nil
            }
        }
}
