//
//  ChatGPTAPICall.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 20.02.24.
//

import SwiftUI

struct ChatGPTAPICall: View {
    @State private var responseText = "Frage ChatGPT etwas..."
    @State private var inputQuestion = "" // Hält die Eingabe des Benutzers

    var body: some View {
        VStack {
            TextField("Stelle eine Frage...", text: $inputQuestion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Frage ChatGPT") {
                askChatGPT(inputQuestion) // Verwendet die Benutzereingabe
            }
            .padding()
            .disabled(inputQuestion.isEmpty) // Deaktiviert den Button, wenn keine Eingabe vorhanden ist

            ScrollView {
                Text(responseText)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }

    func askChatGPT(_ question: String) {
        let apiKey = "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" // Sicherer speichern und laden
        guard let url = URL(string: "https://api.openai.com/v1/completions") else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo-0125", // Überprüfen, ob dies das gewünschte Modell ist
            "prompt": question,
            "temperature": 0.5,
            "max_tokens": 100
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.responseText = "Fehler: \(error.localizedDescription)"
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.responseText = "Fehler: Keine Daten erhalten"
                }
                return
            }
            // Rohdaten-Debugging
            if let dataString = String(data: data, encoding: .utf8) {
                print("Rohdaten: \(dataString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
                DispatchQueue.main.async {
                    self.responseText = decodedResponse.choices.first?.text ?? "Keine Antwort erhalten"
                }
            } catch {
                print("Deserialisierungsfehler: \(error)")
                DispatchQueue.main.async {
                    self.responseText = "Fehler: Antwort konnte nicht verarbeitet werden (\(error.localizedDescription))"
                }
            }
        }.resume()
    }
}

struct ChatGPTResponse: Codable {
    struct Choice: Codable {
        let text: String
    }
    let choices: [Choice]
}

struct ChatGPTAPICall_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTAPICall()
    }
}
