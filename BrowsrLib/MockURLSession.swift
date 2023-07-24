//
//  MockURLSession.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var nextResponse: URLResponse?
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private(set) var resumeWasCalled = false
    
    override func resume() {
        resumeWasCalled = true
    }
}

