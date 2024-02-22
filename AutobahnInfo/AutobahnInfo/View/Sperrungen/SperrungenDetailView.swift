//
//  SperrungenDetailView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 02.02.24.
//

import SwiftUI

struct SperrungenDetailView: View {
    var closure: Closure

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(closure.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                
                Divider()

                Group {
                    Label("Beschreibung", systemImage: "")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    ForEach(closure.description, id: \.self) { description in
                        Text(description)
                            .font(.body)
                            .padding(.bottom, 2)
                    }
                }
                .padding(.vertical)

                Divider()

                Group {
                    Label("Koordinaten", systemImage: "mappin.and.ellipse")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    Text("\(closure.coordinate.lat), \(closure.coordinate.long)")
                        .font(.body)
                        .padding(.vertical, 2)
                }

                Divider()

                Group {
                    Label("Startzeit", systemImage: "clock")
                        .font(.title2)
                        .foregroundColor(.secondary)

                    Text(formatDateString(closure.startTimestamp))
                        .font(.body)
                        .padding(.vertical, 2)
                }
            }
            .listRowBackground(BlurView(style: .extraLight))
            .padding()
        }
        .navigationTitle("Sperrungsdetails")
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
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatDateString(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        if let date = formatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy HH:mm 'Uhr'"
            return outputFormatter.string(from: date)
        } else {
            return "Unbekanntes Datum"
        }
    }
}

struct SperrungenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SperrungenDetailView(closure: Closure(
            extent: "8.8654782,53.0320132,8.8736228,53.0353907",
            identifier: "Beispiel-ID",
            routeRecommendation: [],
            coordinate: ClosureCoordinate(lat: "53.035391", long: "8.873623"),
            footer: [],
            icon: "250",
            isBlocked: "false",
            description: [
                "Beginn: 06.08.2023 16:00",
                "Ende: 31.03.2024 23:59",
                "",
                "A1 Osnabrück - Bremen",
                "zwischen Bremen-Arsten und Bremen-Hemelingen",
                "in beiden Richtungen Parallelfahrbahn gesperrt, Staugefahr, bis 31.03.2024"
            ],
            title: "A1 | AS Bremen-Hemelingen (55) - AS Bremen-Arsten (56)",
            point: "8.873623,53.035391",
            displayType: "CLOSURE",
            lorryParkingFeatureIcons: [],
            future: false,
            subtitle: "Bremen Richtung Osnabrück",
            startTimestamp: "2023-08-06T16:00:00.000+0200"
        ))
    }
}
