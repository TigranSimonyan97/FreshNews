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
        let imagesDirectoryURL = directoryURL.appendingPathComponent("images")
        var isDirectory = ObjCBool(true)
        let isExists = FileManager.default.fileExists(atPath: imagesDirectoryURL.relativePath, isDirectory: &isDirectory)
        if !(isDirectory.boolValue && isExists) {
            do {
                try FileManager.default.createDirectory(atPath: imagesDirectoryURL.relativePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Can`t create image directory for url \(imagesDirectoryURL). Error localized description \(error.localizedDescription)")
            }
        }
        
        return imagesDirectoryURL
    }
    
    func url(for directory: String, and relativePath: String) -> URL? {
        let dirURL = baseURL.appendingPathComponent(directory)
        var isDirectory = ObjCBool(true)
        let isExists = FileManager.default.fileExists(atPath: dirURL.relativePath, isDirectory: &isDirectory)
        if !(isDirectory.boolValue  && isExists) {
            do {
                try FileManager.default.createDirectory(atPath: dirURL.relativePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Can`t create image directory for url \(dirURL). Error localized description \(error.localizedDescription)")
                return nil
            }
        }

        return URL(fileURLWithPath: relativePath, relativeTo: dirURL)
    }
}
