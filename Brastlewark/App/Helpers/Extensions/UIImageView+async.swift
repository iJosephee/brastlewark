//
//  UIImage+async.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import UIKit

extension UIImageView {

    public func loadImageURL(_ theURL: URL?, completion: @escaping (_ finish: Bool) -> Void) {
        guard let url = theURL else { return }
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return completion(false) }
        
            DispatchQueue.main.async {
                guard let image = UIImage(data: data!) else { return completion(false) }
                
                let logoUIImageView = UIImageView(image: image)
                self.contentMode =  UIView.ContentMode.scaleAspectFill
                self.image = logoUIImageView.image
                completion(true)
            }
        }.resume()
    }
}
