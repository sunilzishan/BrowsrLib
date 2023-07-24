//
//  BrowsrClient.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

public class BrowsrClient {
    private let imageDownloader: ImageDownloader
    private let session: URLSessionProtocol
    
    public init(imageDownloader: ImageDownloader = ImageDownloader(), session: URLSessionProtocol = BrowsrLibURLSession()) {
        self.imageDownloader = imageDownloader
        self.session = session
    }
    
    
    /// Fetches a list of organizations from the GitHub API.
    /// - Parameters:
    ///   - completion: A completion handler called when the request is complete.
    ///                 The array of organizations or an error will be returned.
    ///                 The error can be `BrowsrError.invalidURL`, `BrowsrError.invalidData`,
    ///                 `BrowsrError.networkError(Error)`, or `BrowsrError.decodingError(Error)`.
    public func fetchOrganizations(completion: @escaping ([Organization]?, BrowsrError?) -> Void) {
        let endpoint = "https://api.github.com/organizations"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidURL)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
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
    
    
    /// Fetches the avatar picture for a given organization.
    /// - Parameters:
    ///   - organization: The organization for which to fetch the avatar picture.
    ///   - completion: A completion handler called when the request is complete.
    ///                 The image data or an error will be returned.
    ///                 The error can be `BrowsrError.invalidURL`, `BrowsrError.invalidData`, or a network error.
    public func fetchAndStoreAvatarPicture(for organization: Organization, completion: @escaping (Data?, Error?) -> Void) {
        guard let avatarURL = organization.avatarPictureURL else {
            completion(nil, BrowsrError.invalidURL)
            return
        }
        
        
        // Check if the image is already cached
        if let cachedImageData = CacheManager.shared.retrieveImageData(for: "\(organization.id)") {
            completion(cachedImageData, nil)
            return
        }
        
        // Use the imageDownloader to fetch the image data
        imageDownloader.downloadImage(from: avatarURL) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let imageData = data else {
                completion(nil, BrowsrError.invalidData)
                return
            }
            
            // Store the image data in the cache
            CacheManager.shared.storeImageData(imageData, for: "\(organization.id)")
            completion(imageData, nil)
        }
    }
    
    
}

