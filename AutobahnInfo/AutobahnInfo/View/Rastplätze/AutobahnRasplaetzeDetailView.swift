//
//  AutobahnRasplaetzeDetailView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 25.01.24.
//

import SwiftUI
import CoreLocation

struct AutobahnRasplaetzeDetailView: View {
    var road: String
    @StateObject var parkingLorryViewModel = ParkingLorryViewModel()
    @State private var searchText = ""
    @StateObject var favoriteViewModel = FavoritenViewModel()
    @State private var favoritenStatus = [String: Bool]()

    var filteredParkingLorries: [ParkingLorry] {
        if searchText.isEmpty {
            return parkingLorryViewModel.roadsData?.parkingLorry ?? []
        } else {
            return parkingLorryViewModel.roadsData?.parkingLorry.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText) ||
                $0.description.joined().localizedCaseInsensitiveContains(searchText)
            } ?? []
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(filteredParkingLorries, id: \.identifier) { parkingLorry in
                    VStack(alignment: .leading) {
                        HStack {
                            NavigationLink(destination: RastpleatzeMap(coordinate: CLLocationCoordinate2D(latitude: Double(parkingLorry.coordinate.lat) ?? 0.0, longitude: Double(parkingLorry.coordinate.long) ?? 0.0))) {
                                VStack(alignment: .leading) {
                                    Text(parkingLorry.title)
                                        .font(.headline)
                                    Text(parkingLorry.subtitle)
                                        .font(.subheadline)
                                    HStack {
                                        Text("GPS: \(parkingLorry.coordinate.lat), \(parkingLorry.coordinate.long)")
                                        Spacer()
                                        Text(parkingLorry.isBlocked == "true" ? "Gesperrt" : "Offen")
                                            .foregroundColor(parkingLorry.isBlocked == "true" ? .red : .green)
                                    }
                                    ForEach(parkingLorry.description, id: \.self) { desc in
                                        Text(desc)
                                    }
                                }
                            }
                            Spacer()
                            Button(action: {
                                let istBereitsFavorit = favoriteViewModel.istFavorit(parkingLorry: parkingLorry)
                                if istBereitsFavorit {
                                    favoriteViewModel.removeFavorit(parkingLorry: parkingLorry)
                                } else {
                                    favoriteViewModel.addFavorit(parkingLorry: parkingLorry)
                                }
                                favoritenStatus[parkingLorry.identifier] = !istBereitsFavorit
                            }) {
                                Image(systemName: favoritenStatus[parkingLorry.identifier] == true ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding()
                        LinearGradient(gradient: Gradient(colors: [.clear, .orange, .clear]), startPoint: .leading, endPoint: .trailing)
                        .frame(height: 3)
                        .padding(.vertical, 5)
                    }
                    .background(BlurView(style: .systemMaterial))
                    .cornerRadius(5)
                }
                
            }
            .listRowBackground(BlurView(style: .extraLight))
            .padding()
        }
        .toolbarBackground(Color(red: 0.7, green: 0.7, blue: 1.0, opacity: 0.5), for: .navigationBar)
     //   .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(Image("parkplatz_background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
        
        .navigationTitle("Rastplätze auf \(road)")
        .searchable(text: $searchText, prompt: "Suche nach Städten oder Fahrtrichtungen")
        .onAppear {
            parkingLorryViewModel.updateParkingLorryData(for: road)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    updateFavoritenStatus()
                }
        }
    }

    private func updateFavoritenStatus() {
        for parkingLorry in parkingLorryViewModel.roadsData?.parkingLorry ?? [] {
            favoritenStatus[parkingLorry.identifier] = favoriteViewModel.istFavorit(parkingLorry: parkingLorry)
        }
    }
}

struct AutobahnRasplaetzeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnRasplaetzeDetailView(road: "A1")
    }
}
