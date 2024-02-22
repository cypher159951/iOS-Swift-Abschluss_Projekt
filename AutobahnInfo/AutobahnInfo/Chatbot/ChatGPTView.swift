//
//  ChatGPTView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 20.02.24.
//



import SwiftUI

struct ChatGPTView: View {
    
   let apiKey = "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"
    
    var body: some View {
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hallo")
        }
        .padding()
        .onAppear{
            Task{
               let api = ChatGPTAPI(apiKey: apiKey)
                do {
//                    let stream = try await api.sendMessageStream(text: "Wer ist James Bond")
//                    for try await line in stream {
//                        print(line)
//                    }
                    let text = try await api.sendMessage("wer ist James Bond")
                        print(text)
                    
                    let text2 = try await api.sendMessage("wie viele filme hat er gemacht?")
                    print(text2)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ChatGPTVie_Preview: PreviewProvider {
    static var previews: some View {
        ChatGPTView()
    }
}
