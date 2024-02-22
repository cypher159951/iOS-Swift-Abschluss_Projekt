//
//  AuthenticationsView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct AuthenticationsView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var mode: AuthenticationMode = .login
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var showAlert = false

    private var disableAuth: Bool {
        mode == .login ? email.isEmpty || password.isEmpty : email.isEmpty || password.isEmpty || name.isEmpty
    }

    private func switchAuthMode() {
        mode = mode == .login ? .register : .login
    }

    private func authenticate() {
        switch mode {
        case .login:
            userViewModel.login(email: email, password: password)
        case .register:
            userViewModel.register(email: email, password: password, name: name)
        }
        if userViewModel.authError != nil {
            showAlert = true
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image("AutobahnInfo_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                .foregroundColor(.accentColor)
                

                // Glas-Effekt-Container
                VStack(spacing: 16) {
                    if mode == .register {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Passwort", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .background(
                    BlurView(style: .systemUltraThinMaterialDark)
                        .cornerRadius(10)
                        .opacity(0.5)
                ) //  Blur-Effekt
                
                
                .cornerRadius(10)
             //   .overlay(
             //       RoundedRectangle(cornerRadius: 20)
             //           .stroke(Color.white, lineWidth: 1)
             //           .blendMode(.overlay)
              //  )
                
                
                
                
                

                Button(action: authenticate) {
                    Text(mode.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            // Fügt dem Button einen Blur-Effekt als Hintergrund hinzu
                            BlurView(style: disableAuth ? .systemThinMaterialLight : .systemChromeMaterialDark)
                                .cornerRadius(10)
                                .opacity(disableAuth ? 0.5 : 1) // Passt die Opazität basierend auf dem Button-Zustand an
                        )
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3) // Fügt einen Schatten hinzu, um die Lesbarkeit zu verbessern
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(disableAuth ? Color.gray : Color.orange, lineWidth: 0.0) // Verändert die Rahmenfarbe basierend auf dem Zustand
                        )
                        .disabled(disableAuth) // Behält die Logik bei, den Button zu deaktivieren, falls notwendig
                }

                Button(action: switchAuthMode) {
                    Text(mode.alternativeTitel)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(6)
                        .background(
                            BlurView(style: .systemUltraThinMaterialDark)
                                .cornerRadius(10)
                                .opacity(0.5)
                        )
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.3), lineWidth: 0.0)
                        )
                }
    
                Spacer()
            }
            .padding()
            .background(
                NavigationLink(destination: HomeView(), isActive: $userViewModel.isAuthenticated) {
                    EmptyView()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Fehler"), message: Text(userViewModel.authError ?? "Unbekannter Fehler"), dismissButton: .default(Text("OK")) {
                    userViewModel.authError = nil
                })
            }
            .background(
                        Image("authentication_background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                        )
        }
    }
}

// BlurView
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct AuthenticationsView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationsView()
            .environmentObject(UserViewModel())
    }
}
