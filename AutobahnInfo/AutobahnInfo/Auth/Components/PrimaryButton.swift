//
//  PrimaryButton.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action : () -> Void

    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }
        .padding(.vertical,12)
        .background(Color.accentColor)
        .cornerRadius(12)
    }
}

#Preview {
    PrimaryButton(title: "Anmelden", action: {} )
}

