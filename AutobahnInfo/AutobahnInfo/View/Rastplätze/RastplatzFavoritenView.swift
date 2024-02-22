//
//  RastplatzFavoritenView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 29.01.24.
//

import SwiftUI
import CoreLocation

struct RastplatzFavoritenView: View {
    @FetchRequest(
        entity: FavoritenRastplatz.entity(),
        sortDescriptors: []
    ) var favoriten: FetchedResults<FavoritenRastplatz>
    @Environment(\.managedObjectContext) var context

    var body: some View {
        Group {
            if favoriten.isEmpty {
                Text("Füge Favoriten hinzu")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(favoriten, id: \.self) { favorit in
                        NavigationLink(destination: RastpleatzeMap(coordinate: CLLocationCoordinate2D(latitude: Double(favorit.latitude ?? "0.0") ?? 0.0, longitude: Double(favorit.longitude ?? "0.0") ?? 0.0))) {
                            VStack(alignment: .leading) {
                                Text(favorit.title ?? "Unbekannter Titel")
                                    .font(.headline)
                                Text(favorit.subtitle ?? "Keine Beschreibung")
                                    .font(.subheadline)
                                Text("GPS: \(favorit.latitude ?? "N/A"), \(favorit.longitude ?? "N/A")")
                            }
                        }
                        .listRowBackground(BlurView(style: .extraLight))
                     //   .toolbarBackground(Color.gray.opacity(0.8), for: .navigationBar)
                    }
                    
                    .onDelete(perform: entferneFavoriten)
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
                
            }
        }
    }

    private func entferneFavoriten(at offsets: IndexSet) {
        for index in offsets {
            let favorit = favoriten[index]
            context.delete(favorit)
        }
        try? context.save()
    }
}

struct RastplatzFavoritenView_Previews: PreviewProvider {
    static var previews: some View {
        RastplatzFavoritenView()
    }
}
