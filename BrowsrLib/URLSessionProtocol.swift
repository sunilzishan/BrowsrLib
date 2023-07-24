//
//  URLSessionProtocol.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}
