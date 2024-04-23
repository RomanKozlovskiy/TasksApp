//
//  Extension + UIImageView .swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit

extension UIImageView {
    func load(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
