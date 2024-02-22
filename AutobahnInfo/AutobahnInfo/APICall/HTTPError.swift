//
//  HTTPError.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 22.01.24.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case missingData
    case networkError
    case decodingError
}
