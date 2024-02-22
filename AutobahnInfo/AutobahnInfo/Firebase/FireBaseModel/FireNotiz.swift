//
//  Notiz.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 06.02.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireNotiz: Codable, Identifiable {
    
    @DocumentID var id: String?
    var userId: String
    var title: String
    var description: String
    
}
