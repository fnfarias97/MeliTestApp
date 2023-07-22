//
//  UIImageView+URL.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 21/07/2023.
//

import UIKit

extension UIImageView {
    /**

     Extension to set an image from an URL into the imageView

     - Parameters:
         - url: The url address where is located the image
         - mode: The content mode of the image that we want to set. The content mode by default is scaleAspectFit.
     - Returns: Nothing

     */

    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((Bool) -> Void)? = nil) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion?(false) }
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion?(true)
            }

        }.resume()
    }

    /**

     Extension to set an image from an string URL into the imageView

     - Parameters:
         - link: The url string address where is located the image.
         - mode: The content mode of the image that we want to set. The content mode by default is scaleAspectFit.
     - Returns: Nothing

     */

    public func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, completion: completion)
    }
}

