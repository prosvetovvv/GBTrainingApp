//
//  PhotoService.swift
//  GBTrainingApp
//
//  Created by Vitaly Prosvetov on 18.11.2020.
//

import UIKit

struct PhotoService {
    
    let cache = NSCache<NSString, UIImage>()
    
    func downloadPhoto(from urlString: String, to imageView: UIImageView) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            imageView.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { imageView.image = image }
        }
        
        task.resume()
    }
}



