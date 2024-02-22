//
//  NotizEditView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 06.02.24.
//

import SwiftUI

struct NotizEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var notizListViewModel: NotizViewModel
    @StateObject var notizViewModel = NotizViewModel()
    
    let id: String
    
    @State private var title: String
    @State private var description: String
    @State private var showAlert = false
    
    init(notiz: FireNotiz) {
        self.id = notiz.id ?? ""
        self._title = State(initialValue: notiz.title)
        self._description = State(initialValue: notiz.description)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Titel", text: $title)
                    .padding(12)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                TextEditor(text: $description)
                    .frame(minHeight: 100)
                    .padding(12)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
                
                
                Button("Aktualisieren") {
                    notizListViewModel.updateNotiz(with: id, title: title, description: description)
                    dismiss()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Fehler"), message: Text("Es gab ein Problem beim Aktualisieren der Notiz."), dismissButton: .default(Text("OK")))
                }
            }
            .padding(24)
        }
        .navigationTitle("Notiz bearbeiten")
    }
}



struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        NotizEditView(notiz: FireNotiz(userId: "id", title: "Titel", description: "Beschreibung"))
            .environmentObject(NotizViewModel())
    }
}
