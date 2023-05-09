//
//  User.swift
//  TableView
//
//  Created by Jasman Arora on 5/7/23.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let results: [User]
    
}

struct User: Codable, Identifiable {
    let id = UUID()
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    
    
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Codable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}

