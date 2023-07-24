//
//  BrowsrClientTests.swift
//  BrowsrLibTests
//
//  Created by Sunil Zishan on 24.07.23.
//

import XCTest
@testable import BrowsrLib

class BrowsrClientTests: XCTestCase {
    
    func testFetchOrganizations() {
        let client = BrowsrClient()
        
        let expectation = XCTestExpectation(description: "Fetch organizations")
        
        client.fetchOrganizations { (organizations, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(organizations, "Organizations should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchAvatarPicture() {
        let client = BrowsrClient()
        var organization: Organization!
        
        // Create an Organization instance for testing
        organization = Organization(
            login: "testorg",
            id: 123,
            nodeId: nil,
            url: "https://api.github.com/orgs/testorg",
            reposUrl: nil,
            eventsUrl: nil,
            hooksUrl: nil,
            issuesUrl: nil,
            membersUrl: nil,
            publicMembersUrl: nil,
            avatarUrl: "https://avatars.githubusercontent.com/u/2315026?v=4",
            description: nil,
            avatarPictureURL: URL(string: "https://avatars.githubusercontent.com/u/2315026?v=4")
        )
        
        
        let expectation = XCTestExpectation(description: "Fetch avatar picture")
        
        client.fetchAndStoreAvatarPicture(for: organization) { (data, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(data, "Image data should not be nil")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testFetchOrganizations_Success() {
        // Mock URLSession
        let mockSession = MockURLSession()
        
        // Instance of the BrowsrClient with the mock session
        let client = BrowsrClient(session: mockSession)
        
        // Define the expected organizations data
        let jsonData = """
            [{"login": "org1", "id": 8308664, "url": "https://api.github.com/orgs/org1", "avatar_url": "https://avatars.githubusercontent.com/u/8308664?v=4", "description": "Org 1"},
             {"login": "org2", "id": 333801, "url": "https://api.github.com/orgs/org2", "avatar_url": "https://avatars.githubusercontent.com/u/333801?v=4", "description": "Org 2"}]
            """.data(using: .utf8)
        
        mockSession.nextData = jsonData
        
        let expectation = XCTestExpectation(description: "Fetch organizations")
        
        client.fetchOrganizations { (organizations, error) in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(organizations, "Organizations should not be nil")
            XCTAssertEqual(organizations?.count, 2, "Two organizations should be fetched")
            
            let org1 = organizations?[0]
            XCTAssertEqual(org1?.login, "org1")
            XCTAssertEqual(org1?.id, 8308664)
            XCTAssertEqual(org1?.url, "https://api.github.com/orgs/org1")
            XCTAssertEqual(org1?.avatarUrl, "https://avatars.githubusercontent.com/u/8308664?v=4")
            XCTAssertEqual(org1?.description, "Org 1")
            
            let org2 = organizations?[1]
            XCTAssertEqual(org2?.login, "org2")
            XCTAssertEqual(org2?.id, 333801)
            XCTAssertEqual(org2?.url, "https://api.github.com/orgs/org2")
            XCTAssertEqual(org2?.avatarUrl, "https://avatars.githubusercontent.com/u/333801?v=4")
            XCTAssertEqual(org2?.description, "Org 2")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

