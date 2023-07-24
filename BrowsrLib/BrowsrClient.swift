//
//  BrowsrClient.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//


import Foundation

class BrowsrClient {
    
    func fetchOrganizations(completion: @escaping ([Organization]?, BrowsrError?) -> Void) {
        let endpoint = "https://api.github.com/organizations"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, .networkError(error))
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let organizations = try JSONDecoder().decode([Organization].self, from: data)
                completion(organizations, nil)
            } catch let decodingError {
                completion(nil, .decodingError(decodingError))
            }
        }
        
        task.resume()
    }
}
