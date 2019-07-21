//
//  Extensions.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 5/19/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import UIKit
import Alamofire

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: URL){
        
        self.image = nil
        
        // check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // else download and display the image
        Alamofire.request(urlString).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                imageCache.setObject(image, forKey: urlString as AnyObject)
                self.image = image
            }
        }
    }
}
