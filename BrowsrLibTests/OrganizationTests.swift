//
//  OrganizationTests.swift
//  BrowsrLibTests
//
//  Created by Sunil Zishan on 24.07.23.
//

import XCTest
@testable import BrowsrLib

class OrganizationTests: XCTestCase {
    
    func testDecodingValidOrganizationJSON() throws {
        // Given
        let json = """
        {
            "login": "testorg",
            "id": 123,
            "url": "https://api.github.com/orgs/testorg",
            "avatar_url": "https://example.com/avatar.png"
        }
        """.data(using: .utf8)!
        
        // When
        let organization = try JSONDecoder().decode(Organization.self, from: json)
        
        // Then
        XCTAssertEqual(organization.login, "testorg")
        XCTAssertEqual(organization.id, 123)
        XCTAssertEqual(organization.url, "https://api.github.com/orgs/testorg")
        XCTAssertEqual(organization.avatarUrl, "https://example.com/avatar.png")
    }
    
    func testDecodingInvalidOrganizationJSON() {
        // Given
        let json = """
        {
            "id": 123,
            "url": "https://api.github.com/orgs/testorg",
            "avatar_url": "https://example.com/avatar.png"
        }
        """.data(using: .utf8)!
        
        XCTAssertThrowsError(try JSONDecoder().decode(Organization.self, from: json))
    }
}
