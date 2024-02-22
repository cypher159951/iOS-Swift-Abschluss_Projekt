//
//  ChatbotModel.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 19.02.24.
//

import Foundation


func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hallo") {
        return "Hey!"
        
    } else if tempMessage.contains("grüß gott") {
        return "Grüße Gott!"
        
    } else if tempMessage.contains("moin") {
        return "Moin!"
        
    } else if tempMessage.contains("tschüss") {
        return "Ciao, wir sehen uns!"
        
    } else if tempMessage.contains("wie geht es dir ?") {
        return "Mir geht es gut und dir ?"
        
    } else {
        return "Das ist cool"
    }
}
