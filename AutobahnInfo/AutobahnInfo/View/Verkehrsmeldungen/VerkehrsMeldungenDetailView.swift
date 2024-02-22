//
//  VerkehrsmeldungenDetailsView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 01.02.24.
//

import SwiftUI

struct VerkehrsMeldungenDetailView: View {
    var warning: Warning

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(warning.title)
                    .font(.headline)
                    .padding(.bottom, 5)

                Text("Beschreibung:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ForEach(warning.description, id: \.self) { item in
                    Text(item)
                        .font(.body)
                }

                Divider()

                HStack {
                    Text("Koordinaten:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(warning.coordinate.lat), \(warning.coordinate.long)")
                        .font(.body)
                }

                Divider()

                Text("Startzeit:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(formatDateString(warning.startTimestamp))
                    .font(.body)

            }
            .listRowBackground(BlurView(style: .extraLight))
            .padding()
        }
        .navigationTitle("Verkehrsmeldung")
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
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func formatDateString(_ dateString: String) -> String {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]

            if let date = formatter.date(from: dateString) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "HH:mm 'Uhr'"
                return outputFormatter.string(from: date)
            } else {
                return "Ungültige Zeit"
            }
        }
}

struct VerkehrsMeldungenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VerkehrsMeldungenDetailView(warning: Warning(
            extent: "8.64962,50.20362,8.66937,50.28473",
            identifier: "Beispiel-ID",
            routeRecommendation: ["Route 1", "Route 2"],
            coordinate: TrafficWarningCoordinate(lat: "50.284730", long: "8.669370"),
            icon: "101",
            isBlocked: "false",
            description: ["Beginn: 31.12.2023 23:48", "A5 Kassel Richtung Frankfurt", "zwischen Friedberg und Bad Homburger Kreuz", "1 unbeleuchtetes Fahrzeug auf dem Standstreifen"],
            title: "A5 | AS Friedberg (16) - Schäferborn",
            point: "8.669370,50.284730",
            displayType: "WARNING",
            lorryParkingFeatureIcons: [],
            future: false,
            subtitle: "Kassel Richtung Frankfurt",
            startTimestamp: "2023-12-31T23:48:05.000+0100"
        ))
    }
}
