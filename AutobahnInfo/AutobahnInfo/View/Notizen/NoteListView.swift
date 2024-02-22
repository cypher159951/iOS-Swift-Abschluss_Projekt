//
//  NoteView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 23.01.24.
//

import SwiftUI

struct NoteListView: View {
    
    @EnvironmentObject private var userViewModel: UserViewModel
    @StateObject private var notizListViewModel = NotizViewModel()
    
    @State var newNotiz = ""
    @State var notizDescription = ""
    @State private var selectedTab: TabItem = .notiz
  
    
    
    @State private var isAddNotizsheetPresented = false
    
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Image("wallpaper_home2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Notizen")
                        .font(.largeTitle)
                        .padding()
                    List(notizListViewModel.notiz, id: \.id) { notiz in
                        NavigationLink {
                            NoteView(notiz: notiz)
                        } label: {
                            VStack(alignment: .leading){
                                Text(notiz.title)
                                    .font(.headline)
                                Text(notiz.description.prefix(50))
                                    .font(.subheadline)
                            }
                            
                        }
                        .listRowBackground(BlurView(style: .regular))
                        .swipeActions{
                            Button(role: .destructive) {
                                withAnimation {
                                    notizListViewModel.deleteNotiz(with: notiz.id ?? "")
                                }
                            } label: {
                                Label("Löschen", systemImage: "trash")
                                    .tint(Color.red)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(
                        Color.clear
                    )
                    
                //    .navigationTitle("Notizen")
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                                
                                Button{
                                    isAddNotizsheetPresented.toggle()
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                }
                            }
                        
                    }
                }
                
                
                .sheet(isPresented: $isAddNotizsheetPresented) {
                    
                    VStack {
                        Text("Neue Notiz hinzufügen")
                            .font(.title)
                            .padding()
                        
                        TextField("Titel", text: $newNotiz)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        TextField("Beschreibung", text: $notizDescription)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        HStack {
                            Button("Abbrechen") {
                                isAddNotizsheetPresented = false
                            }
                            .foregroundColor(.red)
                            
                            Spacer()
                            
                            Button("Speichern") {
                                notizListViewModel.createNotiz(title: newNotiz, description: notizDescription)
                                newNotiz = ""
                                notizDescription = ""
                                isAddNotizsheetPresented = false
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                }
            }
        }
            .onAppear {
                notizListViewModel.fetchNotiz()
                
            }
        }
}


#Preview {
    NoteListView()
}
