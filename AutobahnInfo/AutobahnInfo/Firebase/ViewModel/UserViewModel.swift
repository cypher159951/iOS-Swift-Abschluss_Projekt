//
//  UserViewModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject{
    
    private let firebaseManager = FirebaseManager.shared
    private var auth = Auth.auth()
    @Published var user : FireUser?
    @Published var isAuthenticated = false
    @Published var userName: String?
    @Published var userEmail: String?
    
    
    init(){
        CheckAuth()
    }
    
    var userIsLoggedIn : Bool{
        return user != nil
    }
    
    
    var email: String {
        user?.email ?? ""
    }
    
    
    private func CheckAuth() {
            guard let currentUser = firebaseManager.auth.currentUser else {
                print("Not logged in")
                return
            }
            
            self.fetchUser(with: currentUser.uid)
        }
    
    @Published var authError: String?
    
    func login(email: String, password : String){
        auth.signIn(withEmail: email, password: password){ authResult, error in
            if let error = error {
                self.authError = error.localizedDescription
                return
            }
            guard let authResult, let email = authResult.user.email else {return}
            print("User with \(email) is logged in with ID: \(authResult.user.uid)")
            
            self.fetchUser(with: authResult.user.uid)
            self.isAuthenticated = authResult.user != nil
            self.userName = "Der eingeloggte Name"
            self.userEmail = email
            
        }
    }
    
    
    
    func register(email: String, password: String, name: String){
        auth.createUser(withEmail: email, password: password){ authResult, error in
            if let error = error {
                self.authError = error.localizedDescription
                return
            }
            guard let authResult, let email = authResult.user.email else {return}
            print("User with \(email) is registeres with id \(authResult.user.uid)")
            
            
            
            self.createUser(with: authResult.user.uid, name: name, email: email)
            
            
            self.login(email: email, password: password)
            self.isAuthenticated = authResult.user != nil
            
        }
    }
    
    
    
    func logout(){
        do{
            try firebaseManager.auth.signOut()
            self.user = nil
            self.isAuthenticated = false
            print("User wurde abgemeldet")
        }catch{
            print("error while logged out: ", error.localizedDescription)
        }
    }
}


    extension UserViewModel {
        
        private func createUser(with id: String, name: String, email: String) {
                let user = FireUser(id: id, name: name, email: email, registeredAt: Date())
                
                do {
                    try firebaseManager.database.collection("users").document(id).setData(from: user)
                } catch let error {
                    print("Fehler beim Speichern des Users: \(error)")
                }
            }
        
        
        private func fetchUser(with id: String) {
            firebaseManager.database.collection("users").document(id).getDocument { document, error in
                if let error {
                    print("Fetching user failed:", error.localizedDescription)
                    return
                }
                
                guard let document else {
                    print("Dokument existiert nicht!")
                    return
                }
                
                do {
                    let user = try document.data(as: FireUser.self)
                    self.user = user
                } catch {
                    print("Dokument ist kein User", error.localizedDescription)
                }
            }
        }
   
}
