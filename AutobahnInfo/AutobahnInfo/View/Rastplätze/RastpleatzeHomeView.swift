//
//  RastpleatzeHomeView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 29.01.24.
//

import SwiftUI

struct RastpleatzeHomeView: View {
    
    var body: some View {
        ZStack{
            Image("parkplatz_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    NavigationLink(destination: AutobahnListRasplaetzeView()) {
                        HomeButtonView(title: "Rastplätze", imageName: "parkingsign.radiowaves.left.and.right")
                    }
                    
                    NavigationLink(destination: RastplatzFavoritenView()) {
                        HomeButtonView(title: "Favoriten", imageName: "star")
                    }
                    
                }
            }
            .padding()
            .navigationTitle("Autobahn Info")
            
        }
    }
    
}

struct RastpleatzeHomeButtonView: View {
    var title: String
    var imageName: String

    var body: some View {
        
        VStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text(title)
                .fontWeight(.semibold)
                
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
    }
}



struct RastpleatzeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RastpleatzeHomeView()
    }
}
