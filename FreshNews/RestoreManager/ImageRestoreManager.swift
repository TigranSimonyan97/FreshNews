//
//  ImageRestoreManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

class ImageRestoreManager: RestoreManager {
    typealias DataType = UIImage
    
    let urlProvider = ImageURLProvider()
    
    func restoreData(from relativePath: String) -> UIImage? {
        let url = urlProvider.url(from: relativePath)
        
        guard let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
            print("There is no image under path \(url.relativePath)")
            return nil
        }
        
        return image
    }
}
