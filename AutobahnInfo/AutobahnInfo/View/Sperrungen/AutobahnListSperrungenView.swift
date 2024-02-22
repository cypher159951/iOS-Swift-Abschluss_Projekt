//
//  AutobahnListSperrungenView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 02.02.24.
//

import SwiftUI

struct AutobahnListSperrungenView: View {
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
            NavigationLink(destination: AutobahnSperrungenListView(road: road)) {
                Text(road)
                    .font(.headline)
            }
            .listRowBackground(BlurView(style: .extraLight))
        }
        .navigationTitle("Autobahnen")
        .toolbarBackground(Color.red.opacity(0.8), for: .navigationBar)
     //   .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(
            Image("sperrungen2_background")
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

struct AutobahnListSperrungenView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnListSperrungenView()
    }
}
