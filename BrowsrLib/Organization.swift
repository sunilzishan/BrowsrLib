//
//  Organization.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

public struct Organization: Codable {
    public let login: String
    public let id: Int
    public let nodeId: String?
    public let url: String
    public let reposUrl: String?
    public let eventsUrl: String?
    public let hooksUrl: String?
    public let issuesUrl: String?
    public let membersUrl: String?
    public let publicMembersUrl: String?
    public let avatarUrl: String?
    public let description: String?
    public let avatarPictureURL: URL?
    
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
    public init(from decoder: Decoder) throws {
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
    
    
    public init(login: String, id: Int, nodeId: String?, url: String, reposUrl: String?, eventsUrl: String?, hooksUrl: String?, issuesUrl: String?, membersUrl: String?, publicMembersUrl: String?, avatarUrl: String?, description: String?, avatarPictureURL: URL?) {
        self.login = login
        self.id = id
        self.nodeId = nodeId
        self.url = url
        self.reposUrl = reposUrl
        self.eventsUrl = eventsUrl
        self.hooksUrl = hooksUrl
        self.issuesUrl = issuesUrl
        self.membersUrl = membersUrl
        self.publicMembersUrl = publicMembersUrl
        self.avatarUrl = avatarUrl
        self.description = description
        self.avatarPictureURL = avatarPictureURL
    }
}

