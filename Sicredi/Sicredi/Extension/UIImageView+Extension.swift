//
//  UIImageView+Extension.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse else { return }
            
            if httpURLResponse.statusCode != 200 {
                let error = NSError(domain: "", code: 1, userInfo: nil)
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                let error = NSError(domain: "", code: 1, userInfo: nil)
                completion(.failure(error))
            }
        }
        .resume()
    }
    func downloaded(from link: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, completion: completion)
    }
}

