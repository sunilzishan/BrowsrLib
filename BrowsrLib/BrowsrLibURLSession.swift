//
//  BrowsrLibURLSession.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

public class BrowsrLibURLSession: URLSessionProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func dataTask(with url: URL, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTask {
        return session.dataTask(with: url, completionHandler: completionHandler)
    }
}
