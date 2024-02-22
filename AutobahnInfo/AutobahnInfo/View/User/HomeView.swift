//
//  HomeView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 24.01.24.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
            NavigationStack {
                ZStack{
                    Image("wallpaper_home2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 20) {
                        Text("Autobahn Info")
                            .font(.largeTitle)
                            .padding()
                     //       .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        HStack(spacing: 20) {
                            NavigationLink(destination: AutobahnListView()) {
                                HomeButtonView(title: "Baustellen", imageName: "car.rear.road.lane")
                            }
                            
                            
                            NavigationLink(destination: RastpleatzeHomeView()) {
                                HomeButtonView(title: "Rastplätze", imageName: "parkingsign.radiowaves.left.and.right")
                            }
                        }
                        
                        HStack(spacing: 20) {
                            NavigationLink(destination: AutobahnListLadesaeulenView()) {
                                HomeButtonView(title: "Ladesäulen", imageName: "powercord")
                            }
                            
                            NavigationLink(destination: AutobahnListVerkehrsMeldungenView()) {
                                HomeButtonView(title: "Verkehrsmeldungen", imageName: "waveform")
                            }
                        }
                        
                        HStack(spacing: 20) {
                            NavigationLink(destination: AutobahnListSperrungenView()) {
                                HomeButtonView(title: "Sperrungen", imageName: "xmark")
                            }
                            
                            NavigationLink(destination: ChatGPTAPICall()) {
                                HomeButtonView(title: "Q&A", imageName: "globe")
                            }
                        }
                    }
                    .padding()
                }
            }
        }
}

struct HomeButtonView: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            switch title{
            case "Baustellen":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.black)
            case "Favoriten":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
            case "Rastplätze":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            case "Ladesäulen":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.green)
            case "Verkehrsmeldungen":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.orange)
            case "Sperrungen":
                Image(systemName: imageName)
                    .font(.largeTitle)
                    .foregroundColor(.red)
            default: Text("Fehler")
            }
            
            
           
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
