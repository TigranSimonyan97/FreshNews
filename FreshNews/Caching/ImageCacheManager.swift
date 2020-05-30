//
//  ImageCacheManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI
import Combine

class ImageCacheManager: CacheManager {
    typealias DataType = Data
 
    let urlProvider = ImageURLProvider()
    
    func cache(_ data: Data, in relativePath: String) {
        let url = urlProvider.url(from: relativePath) 
    
        do {
            try data.write(to: url, options: .atomic)
        } catch let error {
            print("some error \(error.localizedDescription), url \(url)")
        }
    }
    
    func clean() {
        let fileManager = FileManager.default
        let basePath = urlProvider.baseURL.relativePath
        
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: basePath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: basePath + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
}
