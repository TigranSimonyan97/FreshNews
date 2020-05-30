//
//  ImageRetrieveManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

protocol ImageRetrievable : Retrievable where DataType == UIImage  {
    
}

class ImageRetrieveManager: ImageRetrievable {
    typealias DataType = UIImage
    
    private let urlProvider = ImageURLProvider()
    
    private let directory: String
    private let imageRelativePath: String
    
    init(directory: String, imageRelativePath: String) {
        self.directory = directory
        self.imageRelativePath = imageRelativePath
    }

    func retrieveData() -> UIImage? {
        let relativePath = imageRelativePath.replacingOccurrences(of: "/", with: "")
        guard let url = urlProvider.url(for: directory, and: relativePath),
            let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else {
            print("Impossible to retrieve image")
            return nil
        }
        
        return image
    }
}
