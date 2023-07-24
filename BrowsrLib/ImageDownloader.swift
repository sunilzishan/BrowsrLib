//
//  ImageDownloader.swift
//  BrowsrLib
//
//  Created by Sunil Zishan on 24.07.23.
//

import Foundation

class ImageDownloader {
    func downloadImage(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, BrowsrError.invalidData)
                return
            }
            
            completion(data, nil)
        }
        
        task.resume()
    }
}
