//
//  SettingsView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        ZStack{
            Image("wallpaper_home2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Text("Einstellungen")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                
                if let userName = userViewModel.user?.name, let userEmail = userViewModel.userEmail {
                    Text("Angemeldet als: \(userName)")
                        .font(.headline)
                        .padding()
                    
                    Text("E-Mail: \(userEmail)")
                        .font(.subheadline)
                        .padding()
                } else {
                    Text("Nicht angemeldet")
                        .font(.subheadline)
                        .padding()
                }
                
                Spacer()
                
                Button("Abmelden") {
                    userViewModel.logout()
                }
                .padding()
                .frame(maxWidth: 200)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserViewModel())
    }
}

