//
//  URLProvider.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

protocol URLProvider {
    func url(from relativePath: String) -> URL
}
