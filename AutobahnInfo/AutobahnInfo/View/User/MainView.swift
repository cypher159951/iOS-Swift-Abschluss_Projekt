//
//  MainView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct MainView: View {
 
    @State private var selectedTab = "Home"

    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("Home")
                .tint(.black)
                
                

            NoteListView()
                .tabItem {
                    Label("Notiz", systemImage: "note.text")
                }
                .tag("Notiz")
                .tint(.black)
            
            

            SettingsView()
                .tabItem {
                    Label("Einstellungen", systemImage: "gearshape")
                }
                .tag("Einstellungen")
                .tint(.black)
        }
        .tint(getTabColor())

    }
    
    func getTabColor() -> Color {
        switch selectedTab {
        case "Home": return .black
        case "Notiz": return .black
        case "Einstellungen": return .black
        default: return .black
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserViewModel())
    }
}
