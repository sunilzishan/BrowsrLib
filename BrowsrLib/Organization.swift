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
    let nodeId: String
    let url: String
    let reposUrl: String
    let eventsUrl: String
    let hooksUrl: String
    let issuesUrl: String
    let membersUrl: String
    let publicMembersUrl: String
    let avatarUrl: String
    let description: String
}
