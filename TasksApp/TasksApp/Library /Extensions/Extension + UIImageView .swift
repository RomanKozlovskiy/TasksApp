//
//  Extension + UIImageView .swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit

extension UIImageView {
    func load(stringUrl: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image)
                self.image = image
            }
        }
    }
}
