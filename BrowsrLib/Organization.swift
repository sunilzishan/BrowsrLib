//
//  Organization.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

struct Organization: Codable {
    let login: String
    let id: Int
    let nodeId: String?
    let url: String
    let reposUrl: String?
    let eventsUrl: String?
    let hooksUrl: String?
    let issuesUrl: String?
    let membersUrl: String?
    let publicMembersUrl: String?
    let avatarUrl: String?
    let description: String?
    
    // Additional property for avatar picture URL
    let avatarPictureURL: URL?
    
    // Coding keys to handle snake case JSON keys
    private enum CodingKeys: String, CodingKey {
        case login, id, nodeId, url
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case hooksUrl = "hooks_url"
        case issuesUrl = "issues_url"
        case membersUrl = "members_url"
        case publicMembersUrl = "public_members_url"
        case avatarUrl = "avatar_url"
        case description
    }
    
    // Custom initializer to handle avatarPictureURL decoding and any decoding errors.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: Decoding errors of type `BrowsrError.decodingError(Error)`.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Regular properties
        login = try container.decode(String.self, forKey: .login)
        id = try container.decode(Int.self, forKey: .id)
        nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId)
        url = try container.decode(String.self, forKey: .url)
        reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl)
        eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl)
        hooksUrl = try container.decodeIfPresent(String.self, forKey: .hooksUrl)
        issuesUrl = try container.decodeIfPresent(String.self, forKey: .issuesUrl)
        membersUrl = try container.decodeIfPresent(String.self, forKey: .membersUrl)
        publicMembersUrl = try container.decodeIfPresent(String.self, forKey: .publicMembersUrl)
        avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        // Decoding avatarPictureURL as URL
        if let avatarUrlString = avatarUrl, let avatarPictureURL = URL(string: avatarUrlString) {
            self.avatarPictureURL = avatarPictureURL
        } else {
            self.avatarPictureURL = nil
        }
    }
}
