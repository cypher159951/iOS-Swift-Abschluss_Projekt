//
//  AutobahnListRasplaetze.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 25.01.24.
//

import SwiftUI

struct AutobahnListRasplaetzeView: View {
    @StateObject var autobahnlistViewModel = RoadsViewModel()
    @State private var searchText = ""

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
                NavigationLink(destination: AutobahnRasplaetzeDetailView(road: road)) {
                    Text(road)
                        .font(.headline)
                }
                .listRowBackground(BlurView(style: .extraLight))
            }
            .toolbarBackground(Color(red: 0.7, green: 0.7, blue: 1.0, opacity: 0.5), for: .navigationBar)
         //   .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(
                Image("parkplatz_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            //    Color.clear
            )
            .navigationTitle("Autobahnen")
            .searchable(text: $searchText, prompt: "Suche Autobahn")
            .toolbar {
                //Toolbar-Item für den Zugriff auf Favoriten
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RastplatzFavoritenView()) {
                        Image(systemName: "star.fill")
                            .tint(Color.yellow)
                    }
                }
            }
            .onAppear {
                autobahnlistViewModel.fetchRoadsData()
            }
    }
}

struct AutobahnListRasplaetzeView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnListRasplaetzeView()
    }
}
