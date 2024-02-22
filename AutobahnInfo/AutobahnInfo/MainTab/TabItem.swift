//
//  TabItem.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation
import SwiftUI

enum TabItem {
    
    case home, notiz, settings
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case.notiz:
            return "Notiz"
        case.settings:
            return "Einstellungen"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .notiz:
            return "note.text"
        case .settings:
            return "gearshape"
        }
    }
    
    var titleColor: Color {
            switch self {
            case .home:
                return .green
            case .notiz:
                return .green
            case .settings:
                return .black
            }
        }
        
    var iconColor: Color {
        switch self {
        case .home:
            return .black
        case .notiz:
            return .black
        case .settings:
            return .black
        }
        
    }
    
}
