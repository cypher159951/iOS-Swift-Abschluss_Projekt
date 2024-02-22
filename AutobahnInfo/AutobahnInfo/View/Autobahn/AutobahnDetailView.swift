//
//  AutobahnDetailView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct AutobahnDetailView: View {
    @EnvironmentObject var roadworksViewModel: RoadworksViewModel
    @State private var roadworkDetail: [Roadwork]?
    @State private var searchText = ""
    var road: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 2) {
                Text("Informationen für \(road)")
                    .font(.title)
                    .padding()

                TextField("Suche nach Stadt/Ort", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                if let roadworks = roadworkDetail {
                    let filteredRoadworks = searchText.isEmpty ? roadworks : roadworks.filter {
                        $0.subtitle.localizedCaseInsensitiveContains(searchText)
                    }
                    
                    

                    ForEach(filteredRoadworks, id: \.self) { roadwork in
                        GroupBox {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Autobahn: \(roadwork.title)")
                                Text("Fahrtrichtung: \(roadwork.subtitle)")
                                Text("Baustelle: \(roadwork.description.joined(separator: "\n"))")
                            }
                            
                            
                        }
                        .background(BlurView(style: .systemMaterial))
                       // .opacity(0.5)
                        .cornerRadius(5)
                        .padding()
                        LinearGradient(gradient: Gradient(colors: [.clear, .orange, .clear]), startPoint: .leading, endPoint: .trailing)
                                                   .frame(height: 3)
                                                   .padding(.vertical, 5)
                    }
                    
                } else if roadworksViewModel.roadworks.isEmpty {
                    GroupBox {
                        Text("Lade Daten...")
                            .italic()
                            .onAppear {
                                roadworksViewModel.fetchRoadsworksData(for: road)
                            }
                    }
                } else {
                    GroupBox {
                        Text("Keine Details verfügbar für \(road).")
                            .italic()
                    }
                    
                }
            }
            
            .task {
                roadworkDetail = await roadworksViewModel.roadworkInfo(for: road)
            }
            
        }
        
        .background(
            Image("baustellen_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            )
        .toolbarBackground(Color.gray.opacity(0.8), for: .navigationBar)
        
    }
    
}


struct AutobahnDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnDetailView(road: "A1")
            .environmentObject(RoadworksViewModel())
    }
}

