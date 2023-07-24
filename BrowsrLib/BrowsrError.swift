//
//  BrowsrError.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

enum BrowsrError: Error {
    case invalidURL
    case invalidData
    case networkError(Error)
    case decodingError(Error)
}
