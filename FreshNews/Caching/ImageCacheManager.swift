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
    var cachedObjectsCount: Int? { get }
    var lastCleanupDate: Date? { get }
}

class ImageCacheManager: ImageCacheable {
    typealias ObjectType = UIImage
    
    private static let lastCleanupDateKey = "lastCleanupDateKey"
    
    private let urlProvider = ImageURLProvider()

    private let directory: String
    private let imageRelativePath: String
    
    var cachedObjectsCount: Int? {
        let fileManager = FileManager.default
        let basePath = urlProvider.baseURL.appendingPathComponent(directory).absoluteString
        return try? fileManager.contentsOfDirectory(atPath: basePath).count
    }
    
    var lastCleanupDate: Date? {
        UserDefaults.standard.string(forKey: ImageCacheManager.lastCleanupDateKey)?.toDate()
    }
    
    var basePath: String {
        urlProvider.baseURL.appendingPathComponent(directory).absoluteString
    }
    
    init(directory: String, imageRelativePath: String) {
        self.directory = directory
        self.imageRelativePath = imageRelativePath
    }
     
    func cache(_ object: UIImage) {
        clearCacheIfNeeded()
        
        let relativePath = imageRelativePath.replacingOccurrences(of: "/", with: "")

        guard let data = object.pngData(), let url = urlProvider.url(for: directory, and: relativePath) else {
            print("Can`t cache image. Impossible to get png data from image")
            return
        }
        
        do {
            try data.write(to: url, options: .atomic)
        } catch let error {
            print("Data write error \(error.localizedDescription), url \(url)")
        }
    }

    func clean() {
        guard let cachedPaths = cachedFilesPaths() else {
            print("There is no cached files in directory \(directory)")
            return
        }
        
        do {
            try cachedPaths.forEach { try FileManager.default.removeItem(atPath: basePath + $0) }
            UserDefaults.standard.set(Date().toString(), forKey: ImageCacheManager.lastCleanupDateKey)
            print("Cached images cleaned up")
        } catch {
            print("Could not clear temp folder: \(error)")
        }

    }
    
    func clearCacheIfNeeded() {
        let lastCleanupDateString = UserDefaults.standard.string(forKey: ImageCacheManager.lastCleanupDateKey)
        let lastCleanupDate = lastCleanupDateString?.toDate()
        let isDayPassedAfterLastCleanup = lastCleanupDate != nil ? isOneDayPassed(from: lastCleanupDate!) : false
        
        let cachedObjectsCountGreaterThenPermissible = cachedObjectsCount != nil ? cachedObjectsCount! > 200 : false
        if cachedObjectsCountGreaterThenPermissible || isDayPassedAfterLastCleanup {
            clean()
        }
    }
    
    //MARK: - Helpers
    private func cachedFilesPaths() -> [String]? {
        try? FileManager.default.contentsOfDirectory(atPath: basePath)
    }
    
    private func dayDiff(startDate: Date, endDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
    }

    private func isOneDayPassed(from date: Date) -> Bool {
        guard let days = dayDiff(startDate: date, endDate: Date()) else { return false }
        return days > 1
    }
}
