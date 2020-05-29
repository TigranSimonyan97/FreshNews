//
//  ImageRestoreManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

class ImageRestoreManager: RestoreManager {
    typealias DataType = UIImage
    
    func restoreData(from path: String) -> UIImage? {
        guard let image = UIImage(contentsOfFile: path) else {
            print("There is no image under path")
            return nil
        }
        
        return image
    }
}
