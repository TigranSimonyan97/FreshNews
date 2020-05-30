//
//  ImageURLProvider.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

class ImageURLProvider :  PathProvider {
    
    final var baseURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func path(from relativePath: String) -> URL {
        return baseURL.appendingPathComponent("\(relativePath).png")
    }
}
