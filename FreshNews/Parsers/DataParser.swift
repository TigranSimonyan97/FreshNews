//
//  DataParser.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

protocol DataParser {
    associatedtype DataType
    
    func parse(data: Data) -> DataType
}
