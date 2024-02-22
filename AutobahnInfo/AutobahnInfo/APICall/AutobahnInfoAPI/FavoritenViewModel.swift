//
//  FavoritenViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 29.01.24.
//

import Foundation
import CoreData

class FavoritenViewModel: ObservableObject {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistentStore.shared.context) {
        self.context = context
    }

    // Favoriten hinzufügen
    func addFavorit(parkingLorry: ParkingLorry) {
        let neuerFavorit = FavoritenRastplatz(context: context)
        neuerFavorit.title = parkingLorry.title
        neuerFavorit.subtitle = parkingLorry.subtitle
        neuerFavorit.latitude = parkingLorry.coordinate.lat
        neuerFavorit.longitude = parkingLorry.coordinate.long
        neuerFavorit.identifier = parkingLorry.identifier
        
        saveContext()
    }

    // Überprüfen, ob ein Rastplatz ein Favorit ist
    func istFavorit(parkingLorry: ParkingLorry) -> Bool {
        let fetchRequest: NSFetchRequest<FavoritenRastplatz> = FavoritenRastplatz.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", parkingLorry.identifier)

        do {
            let ergebnisse = try context.fetch(fetchRequest)
            return !ergebnisse.isEmpty
        } catch {
            print("Fehler beim Abrufen von Favoriten: \(error)")
            return false
        }
    }

    // Favoriten entfernen
    func removeFavorit(parkingLorry: ParkingLorry) {
        let fetchRequest: NSFetchRequest<FavoritenRastplatz> = FavoritenRastplatz.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", parkingLorry.identifier)

        do {
            let ergebnisse = try context.fetch(fetchRequest)
            for objekt in ergebnisse {
                context.delete(objekt)
            }
            saveContext()
        } catch {
            print("Fehler beim Entfernen des Favoriten: \(error)")
        }
    }

    // In CoreData speichern
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Fehler beim Speichern in CoreData: \(error)")
        }
    }
}
