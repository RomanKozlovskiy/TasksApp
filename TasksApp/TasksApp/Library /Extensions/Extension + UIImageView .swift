//
//  Extension + UIImageView .swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit

extension UIImageView {
    
    private var imageCache: NSCache<NSString, UIImage> {
        NSCache<NSString, UIImage>()
    }
    
    func downloadImage(stringUrl: String) {
        if let cachedImage = imageCache.object(forKey: stringUrl as NSString) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: stringUrl) else { return }
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self else {
                        return
                }
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: stringUrl as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            dataTask.resume()
        }
    }
}
