//
//  LadensäulenListView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 30.01.24.
//

import SwiftUI

struct AutobahnListLadesaeulenView: View {
    @StateObject var autobahnlistViewModel = RoadsViewModel()
    @State private var searchText = ""
    @State private var chargingStationsViewModels: [String: ElectricChargingStationViewModel] = [:]

    var filteredRoads: [String] {
        let roads = autobahnlistViewModel.roadsData.roads
        if searchText.isEmpty {
            return roads
        } else {
            return roads.filter { $0.localizedStandardContains(searchText) }
        }
    }

    var body: some View {
        List(filteredRoads, id: \.self) { road in
            NavigationLink(destination: LadeSaeulenDetailView(viewModel: chargingStationsViewModels[road] ?? ElectricChargingStationViewModel())) {
                Text(road)
                    .font(.headline)
            }
            .listRowBackground(BlurView(style: .extraLight))
        }
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
        .navigationTitle("Autobahnen")
        .searchable(text: $searchText, prompt: "Suche Autobahn")
        .onAppear {
            autobahnlistViewModel.fetchRoadsData()
            loadChargingStationsData()
        }
    }

    private func loadChargingStationsData() {
        for road in autobahnlistViewModel.roadsData.roads {
            let viewModel = ElectricChargingStationViewModel()
            viewModel.updateElectricChargingStations(for: road)
            chargingStationsViewModels[road] = viewModel
        }
    }
}

struct AutobahnListLadesaeulenView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnListLadesaeulenView()
    }
}
