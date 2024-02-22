//
//  NoteView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 06.02.24.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject var notizViewModel: NotizViewModel
    let notiz: FireNotiz
    @State private var showingEditView = false
    
    
    var body: some View {
        ZStack{
            Image("wallpaper_home2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        
        VStack {
            
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            
            Text(notiz.title)
                .font(.title)
                .fontWeight(.bold)
            
            
            Text(notiz.description)
                .font(.body)
                .padding()
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Bearbeiten") {
                    showingEditView = true
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            NotizEditView(notiz: notiz)
        }
    }
}
}

 struct ArtikelView_Previews: PreviewProvider {
 static var previews: some View {
 NoteView(notiz: FireNotiz(userId: "id", title: "Notiz", description: "Deine Notiz"))
 .environmentObject(NotizViewModel())
 }
 }
 
