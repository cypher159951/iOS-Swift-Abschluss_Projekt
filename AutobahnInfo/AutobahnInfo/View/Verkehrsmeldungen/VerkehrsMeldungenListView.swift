//
//  VerkehrsMeldungenListView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 01.02.24.
//

import SwiftUI

struct VerkehrsMeldungenListView: View {
    var road: String
    @StateObject var warningServiceViewModel = WarningServiceViewModel()

    var body: some View {
        Group {
            if warningServiceViewModel.warnings.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                    Text("Keine Verkehrsmeldungen")
                        .font(.headline)
                }
                .toolbarBackground(Color.orange.opacity(0.8), for: .navigationBar)
             //   .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(
                    Image("wallpaper_home2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                //    Color.clear
                )
                
                .padding()
            } else {
                List(warningServiceViewModel.warnings, id: \.identifier) { warning in
                    NavigationLink(destination: VerkehrsMeldungenDetailView(warning: warning)) {
                        Text(warning.title)
                            .font(.headline)
                    }
                    .listRowBackground(BlurView(style: .extraLight))
                }
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
                
            }
            
            
        }
        
        .navigationTitleView(Text("Verkehrsmeldungen für \(road)"))
        .onAppear {
            warningServiceViewModel.loadWarnings(for: road)
        }
        
    }
    
}

extension View {
    func navigationTitleView(_ view: Text) -> some View {
        self.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    view.font(.headline).lineLimit(1)
                }
            }
    }
}

struct VerkehrsMeldungenListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VerkehrsMeldungenListView(road: "A2")
        }
    }
}
 
