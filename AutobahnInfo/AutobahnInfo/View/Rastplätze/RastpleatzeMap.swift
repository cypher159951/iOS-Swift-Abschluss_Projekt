//
//  RastpleatzeMap.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 26.01.24.
//

import SwiftUI
import CoreLocation
import MapKit

struct RastpleatzeMap: View {
    @State private var region: MKCoordinateRegion
    @State private var initialCoordinate = CLLocationCoordinate2D(latitude: 50.804062, longitude: 7.559477)
    let zoomStep: Double = 0.005

    struct MapAnnotationItem: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
    }

    @ObservedObject var locationViewModel: LocationViewModel

    @State private var isNavigationActive = false

    var coordinate: CLLocationCoordinate2D 

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
        _locationViewModel = ObservedObject(initialValue: LocationViewModel())
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region,
                annotationItems: [MapAnnotationItem(coordinate: coordinate)]) { item in
                    MapMarker(coordinate: item.coordinate)
                }

            // Zoom Buttons
            VStack {
                Button(action: zoomIn) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }

                Button(action: zoomOut) {
                    Image(systemName: "minus")
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
            }
            .padding(.trailing)

            // Navigation Button
            VStack {
                Spacer()
                Button(action: {
                    // Überprüfe die Standortberechtigung
                    if locationViewModel.userLocation == nil {
                        // Der Benutzer hat die Berechtigung noch nicht erteilt oder deaktiviert
                        locationViewModel.requestLocationPermission()
                    } else {
                        // Navigationslogik einfügen
                        let userLocation = locationViewModel.userLocation!
                        let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        let distance = userLocation.distance(from: destinationLocation) / 1000.0 // Entfernung in km
                        let travelTime = calculateTravelTime(distance: distance)
                        
                        // Zeige die Entfernung und Ankunftszeit an
                        let alert = UIAlertController(title: "Navigation starten", message: String(format: "Entfernung: %.2f km\nAnkunftszeit: %@", distance, travelTime), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }) {
                    Text("Navigation starten")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }
            }
            .padding()
        }
    }

    private func zoomIn() {
        let newDelta = max(region.span.latitudeDelta - zoomStep, 0.005)
        region.span = MKCoordinateSpan(latitudeDelta: newDelta, longitudeDelta: newDelta)
    }

    private func zoomOut() {
        let newDelta = min(region.span.latitudeDelta + zoomStep, 180.0)
        region.span = MKCoordinateSpan(latitudeDelta: newDelta, longitudeDelta: newDelta)
    }

    private func calculateTravelTime(distance: Double) -> String {
        
        let averageSpeedKMH = 60.0 // Durchschnittsgeschwindigkeit von 60 km/h
        let travelTimeHours = distance / averageSpeedKMH
        let travelTimeMinutes = travelTimeHours * 60.0
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        
        if let formattedTime = formatter.string(from: TimeInterval(travelTimeMinutes * 60)) {
            return formattedTime
        } else {
            return "Unbekannt"
        }
    }
}

struct RastpleatzeMap_Previews: PreviewProvider {
    static var previews: some View {
        RastpleatzeMap(coordinate: CLLocationCoordinate2D(latitude: 54.362572, longitude: 10.979850))
    }
}
