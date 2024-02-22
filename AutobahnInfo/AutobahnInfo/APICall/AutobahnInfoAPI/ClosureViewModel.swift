//
//  ClosureViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 02.02.24.
//

//
//  ParkingLorryViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 25.01.24.
//


import Foundation

class ClosureViewModel: ObservableObject {
    @Published var closures: [Closure] = []
    @Published var selectedClosure: Closure?

    func fetchClosures(for road: String) {
        Task {
            do {
                let closures = try await fetchClosureList(for: road)
                DispatchQueue.main.async {
                    self.closures = closures
                }
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }

    func selectClosure(_ closure: Closure) {
        selectedClosure = closure
    }

    private func fetchClosureList(for road: String) async throws -> [Closure] {
        guard let url = URL(string: "https://verkehr.autobahn.de/o/autobahn/\(road)/services/closure") else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let closureResponse = try JSONDecoder().decode(ClosureResponse.self, from: data)
        return closureResponse.closure
    }
}

