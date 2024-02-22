//
//  AutobahnList.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct AutobahnListView: View {
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
                NavigationLink(destination: AutobahnDetailView(road: road)) {
                    
                    VStack(alignment: .leading){
                        Text(road)
                            .font(.headline)
                            
                    }
                }
                .listRowBackground(BlurView(style: .extraLight))
            }
        
            .navigationTitle("Baustellen")
            .toolbarBackground(Color.gray.opacity(0.8), for: .navigationBar)
         //   .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(
                Image("baustellen_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            //    Color.clear
            )
            .navigationTitle("Autobahnen")
            .searchable(text: $searchText, prompt: "Suche Autobahn")
            .onAppear {
                autobahnlistViewModel.fetchRoadsData()
            }
        
    }
}

struct AutobahnListView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnListView()
    }
}
