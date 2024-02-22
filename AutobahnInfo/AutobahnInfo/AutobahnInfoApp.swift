//
//  AutobahnInfoApp.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI
import Firebase

@main
struct AutobahnInfoApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var roadsViewModel = RoadsViewModel()
    @StateObject private var roadworksViewModel = RoadworksViewModel()
    @StateObject private var notizViewModel = NotizViewModel()
    let persistentStore = PersistentStore.shared

    var body: some Scene {
        WindowGroup {
            if userViewModel.userIsLoggedIn {
                NavigationStack {
                    MainView()
                }
                .environmentObject(userViewModel)
                .environmentObject(roadsViewModel)
                .environmentObject(roadworksViewModel)
                .environmentObject(notizViewModel)
                .environment(\.managedObjectContext, persistentStore.context)
                
                
                
            } else {
                AuthenticationsView()
                    .environmentObject(userViewModel)
                    .environment(\.managedObjectContext, persistentStore.context)
            }
        }
    }
}
