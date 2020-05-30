//
//  CacheManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

protocol CacheManager {
    associatedtype DataType

    func cache(_ data: DataType, in relativePath: String)
    
    func clean()
}
