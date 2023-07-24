//
//  BrowsrClient.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//


import Foundation

class BrowsrClient {
    private let imageDownloader: ImageDownloader
    
    init(imageDownloader: ImageDownloader = ImageDownloader()) {
        self.imageDownloader = imageDownloader
    }
    
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
    
    func fetchAndStoreAvatarPicture(for organization: Organization, completion: @escaping (Data?, Error?) -> Void) {
        guard let avatarURL = organization.avatarPictureURL else {
            completion(nil, BrowsrError.invalidURL)
            return
        }
        
        imageDownloader.downloadImage(from: avatarURL) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
    }
}
