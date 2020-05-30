//
//  ImageCacheManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI
import Combine

protocol ImageCacheable : Cacheable where ObjectType == UIImage {
    
}

class ImageCacheManager: ImageCacheable {
    typealias ObjectType = UIImage
    
    private let urlProvider = ImageURLProvider()

    private let directory: String
    private let imageRelativePath: String
    
    init(directory: String, imageRelativePath: String) {
        self.directory = directory
        self.imageRelativePath = imageRelativePath
    }
     
    func cache(_ object: UIImage) {
        guard let data = object.pngData() else {
            print("Can`t cache image. Impossible to get png data from image")
            return
        }
        
        let url = urlProvider.url(from: "\(directory)/\(imageRelativePath)")
        
        do {
            try data.write(to: url, options: .atomic)
        } catch let error {
            print("some error \(error.localizedDescription), url \(url)")
        }
    }

    func clean() {
//        let fileManager = FileManager.default
//        let basePath = urlProvider.baseURL.absoluteString
//        guard let filePaths = try? fileManager.contentsOfDirectory(atPath: basePath) else {
//            return
//        }

//        let lastCleanupDateString = UserDefaults.standard.string(forKey: ImageCacheManager.lastCleanupDateKey)
//        let lastCleanupDate = lastCleanupDateString?.toDate()
//        let isADayPassed = lastCleanupDate != nil ? isOneDayPassed(from: lastCleanupDate!) : false
        
//        if filePaths.count > 200 ||  isADayPassed {
//            do {
//                try filePaths.forEach { try fileManager.removeItem(atPath: basePath + $0) }
////                UserDefaults.standard.set(Date().toString(), forKey: ImageCacheManager.lastCleanupDateKey)
//                print("Cached images cleaned up")
//            } catch {
//                print("Could not clear temp folder: \(error)")
//            }
//        }
    }
    
//    private func dayDiff(startDate: Date, endDate: Date) -> Int? {
//        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
//    }
//
//    func isOneDayPassed(from date: Date) -> Bool {
//        guard let days = dayDiff(startDate: date, endDate: Date()) else { return false }
//        return days > 1
//    }
}
