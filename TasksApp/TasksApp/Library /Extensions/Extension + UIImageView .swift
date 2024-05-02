//
//  Extension + UIImageView .swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit

extension UIImageView {
        
    func downloadImage(stringUrl: String, completion: @escaping (UIImage) -> Void) {

        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  data != nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return
            }
            guard let image = UIImage(data: data!) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
    }
}
