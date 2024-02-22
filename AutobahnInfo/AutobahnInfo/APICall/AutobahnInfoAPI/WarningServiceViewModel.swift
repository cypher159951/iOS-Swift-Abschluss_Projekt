//
//  WarningServiceViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 31.01.24.
//

import Foundation

class WarningServiceViewModel: ObservableObject {
    @Published var warnings = [Warning]()

    func loadWarnings(for road: String) {
        Task {
            do {
                let warningsResponse = try await fetchWarnings(for: road)
                DispatchQueue.main.async {
                    self.warnings = warningsResponse
                }
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }

    private func fetchWarnings(for road: String) async throws -> [Warning] {
        let urlString = "https://verkehr.autobahn.de/o/autobahn/\(road)/services/warning"
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        // Drucken des rohen JSON-Strings
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Empfangener JSON-String: \(jsonString)")
        }

        // Überprüfen der HTTP-Antwort und Statuscode
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("HTTP-Fehler: Statuscode \(httpResponse.statusCode)")
            throw HTTPError.networkError
        }

        do {
            let warningsResponse = try JSONDecoder().decode(TrafficWarningResponse.self, from: data)
            return warningsResponse.warnings
        } catch {
            print("Decodierungsfehler: \(error)")
            throw HTTPError.decodingError
        }
    }
}

