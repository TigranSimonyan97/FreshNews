//
//  ImageCacheManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

class ImageCacheManager: CacheManager {
    typealias DataType = UIImage
    
    func cache(_ data: UIImage, in path: String) {
        let fileManager = FileManager()
        
        guard let imageData = data.pngData() else {
            print("Impossible to get data from image")
            return
        }
        
        fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
    }
}
