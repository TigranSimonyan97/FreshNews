//
//  ImageURLProvider.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

class ImageURLProvider :  URLProvider {
    
    final var baseURL: URL {
        let directoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagesDirectoryURL  = directoryURL.appendingPathComponent("image")
        var isDirectory = ObjCBool(true)
        _ = FileManager.default.fileExists(atPath: imagesDirectoryURL.absoluteString, isDirectory: &isDirectory)
        if !isDirectory.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: imagesDirectoryURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Can`t create image directory for url \(imagesDirectoryURL). Error localized description \(error.localizedDescription)")
            }
        }
        
        return imagesDirectoryURL
    }
    
    func url(from relativePath: String) -> URL {
        return URL(fileURLWithPath: relativePath, relativeTo: baseURL)
    }
}
