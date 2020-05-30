//
//  RetrieveManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

protocol Retrievable {
    associatedtype DataType
    
    func retrieveData() -> DataType?
}
