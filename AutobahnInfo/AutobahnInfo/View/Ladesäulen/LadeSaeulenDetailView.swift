//
//  LadeSäulenDetailView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 30.01.24.
//


import SwiftUI
import CoreLocation

struct LadeSaeulenDetailView: View {
    @ObservedObject var viewModel: ElectricChargingStationViewModel
    @State private var searchText = ""
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil

    var filteredStations: [ElectricChargingStationData] {
        if searchText.isEmpty {
            return viewModel.electricChargingStations
        } else {
            return viewModel.electricChargingStations.filter { station in
                let titleMatches = station.title.localizedCaseInsensitiveContains(searchText)
                let descriptionMatches = station.description.contains { descriptionLine in
                    return descriptionLine.localizedCaseInsensitiveContains(searchText)
                }
                return titleMatches || descriptionMatches
            }
        }
    }

    var body: some View {
        List(filteredStations, id: \.self) { station in
            Section {
                VStack(alignment: .leading) {
                    Text(station.title)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 4)
                        .onTapGesture {
                            if let latitude = Double(station.coordinate.lat), let longitude = Double(station.coordinate.long) {
                                selectedCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            }
                        }

                    Text(station.subtitle)
                        .font(.headline)
                        .foregroundColor(.gray)

                    LinearGradient(gradient: Gradient(colors: [.clear, .orange, .clear]), startPoint: .leading, endPoint: .trailing)
                        .frame(height: 3)
                        .padding(.vertical, 5)

                    HStack {
                        Image(systemName: station.isBlocked ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                            .foregroundColor(station.isBlocked ? .red : .green)
                            .font(.title)

                        Text(station.isBlocked ? "Blockiert" : "Nicht blockiert")
                            .font(.headline)
                    }
                    .padding(.top, 4)

                    Text("Ladepunkte:")
                        .font(.headline)
                        .padding(.top, 8)

                    ForEach(station.description, id: \.self) { descriptionLine in
                        Text(descriptionLine)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .listRowBackground(BlurView(style: .extraLight))
        }
        .navigationBarTitle("Ladesäulen Details", displayMode: .inline)
        .toolbarBackground(Color.green.opacity(0.5), for: .navigationBar)
     //   .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(
            Image("ladesäulen-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        //    Color.clear
        )
        .searchable(text: $searchText, prompt: "Suche nach Ladepunkten")
        .background(
            NavigationLink(
                "", destination: LadesaeulenMap(coordinate: selectedCoordinate ?? CLLocationCoordinate2D(), selectedCoordinate: $selectedCoordinate),
                isActive: Binding<Bool>(
                    get: { selectedCoordinate != nil },
                    set: { isActive in
                        if !isActive {
                            selectedCoordinate = nil 
                        }
                    }
                )
            )
        )
    }
}



struct LadeSaeulenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LadeSaeulenDetailView(viewModel: ElectricChargingStationViewModel())
    }
}
