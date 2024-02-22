//
//  NotizViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 06.02.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class NotizViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    @Published var notiz = [FireNotiz]()
    
    
}


extension NotizViewModel {
    

    func createNotiz(title: String, description: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let notiz = FireNotiz(userId: userId, title: title,description: description)
        
        do {
            try FirebaseManager.shared.database.collection("notiz").addDocument(from: notiz) { error in
                if let error = error {
                    print("Fehler beim Speichern der Notiz: \(error)")
                } else {
                    self.fetchNotiz()
                }
            }
        } catch let error {
            print("Fehler beim Speichern der Notiz: \(error)")
        }
    }
}



extension NotizViewModel {
    func fetchNotiz() {
        guard let userId = FirebaseManager.shared.userId else { return }

        self.listener = FirebaseManager.shared.database.collection("notiz")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim Laden der Notiz")
                    return
                }
                
                self.notiz = documents.compactMap { queryDocumentSnapshot -> FireNotiz? in
                    try? queryDocumentSnapshot.data(as: FireNotiz.self)
                }
            }
    }

    
   
    func removeListener() {
        notiz.removeAll()
        listener?.remove()
    }
    
}



extension NotizViewModel {
    func updateNotiz(with id: String, title: String, description: String) {
        let data = [
            "title": title,
            "description": description,
        ] as [String : Any]

        FirebaseManager.shared.database.collection("notiz").document(id).setData(data, merge: true) { error in
            if let error {
                print("Notiz wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
            print("Notiz aktualisiert!")
        }
    }
}




extension NotizViewModel {
    

    func deleteNotiz(with id: String) {
        FirebaseManager.shared.database.collection("notiz").document(id).delete() { error in
            if let error {
                print("Notiz kann nicht gelöscht werden", error.localizedDescription)
                return
            }
            
            print("Notiz mit ID \(id) gelöscht")
        }
    }
    
}
