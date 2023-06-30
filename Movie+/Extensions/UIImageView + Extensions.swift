//
//  UIImageView + Extensions.swift
//  Movie+
//
//  Created by Ikmal Azman on 25/06/2023.
//

import UIKit

let imageCache = NSCache< NSString, UIImage>()

enum ImageSize {
    case backdrop
    case thumbnail
}

extension ImageSize {
    var path : String {
        switch self {
        case .backdrop:
            return "/original"
        case .thumbnail:
            return "/w154"
        }
    }
    
    var placeholderImageName : String {
        switch self {
        case .backdrop:
            return "backdropPlaceholder"
        case .thumbnail:
            return "thumbnailPlaceholder"
        }
    }
}

extension UIImageView {
    /// Allow to download image asyncronously, store downloaded image into cache and download new image if image in cache not availabel
    func downloadImage(fromURLString urlString : String, imageSize : ImageSize = .thumbnail) {
        guard let url = URL(string: APIProvider.imageDB.url + imageSize.path + urlString) else {
            return
        }
        
        self.image = nil
        
        /// Retrieve image from cache if available, if not download new image
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                let placeHolderImage = UIImage(named:imageSize.placeholderImageName) ?? UIImage()
                /// Store downloaded image data into cache
                imageCache.setObject(imageToCache ?? placeHolderImage, forKey: NSString(string: urlString))
                
                self.image = imageToCache
            }
        }
        task.resume()
    }
}
