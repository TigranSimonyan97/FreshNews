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
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func url(from relativePath: String) -> URL {
        return URL(fileURLWithPath: relativePath, relativeTo: baseURL)
    }
}
