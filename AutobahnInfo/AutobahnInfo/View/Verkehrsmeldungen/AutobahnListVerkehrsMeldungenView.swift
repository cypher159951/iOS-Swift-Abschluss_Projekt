//
//  AutobahnListVerkehrsMeldungenView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 01.02.24.
//

import SwiftUI

struct AutobahnListVerkehrsMeldungenView: View {
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
                    NavigationLink(destination: VerkehrsMeldungenListView(road: road)) {
                        Text(road)
                            .font(.headline)
                    }
                    .listRowBackground(BlurView(style: .extraLight))
                }
            .navigationTitle("Autobahnen")
            .toolbarBackground(Color(red: 1.0, green: 0.55, blue: 0.0, opacity: 0.9), for: .navigationBar)
         //   .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(
                Image("wallpaper_home2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            //    Color.clear
            )
            .searchable(text: $searchText, prompt: "Suche Autobahn")
            .onAppear {
                autobahnlistViewModel.fetchRoadsData()
            }
    }
}

struct AutobahnListVerkehrsMeldungenView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnListVerkehrsMeldungenView()
    }
}
