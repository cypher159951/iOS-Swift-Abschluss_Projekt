//
//  AuthenticationMode.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation


enum AuthenticationMode{
    case login, register
    
    var title: String{
        switch self {
        case .login:
            return "Anmelden"
        case .register:
            return "Registrieren"
        }
    }
    
    var alternativeTitel: String{
        switch self {
        case .login:
            return "Noch kein Konto? Registrieren ->"
        case .register:
            return "Schon registriert? Anmelden ->"
        }
    }
}
