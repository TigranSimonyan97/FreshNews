//
//  AsyncImage.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/29/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    let urlString: String
    private let placeholder: Placeholder?

    init(urlString: String, placeholder: Placeholder? = nil ) {
        self.urlString = urlString
        self.placeholder = placeholder
    }
    
    var body: some View {
        image.onAppear {
            self.imageLoader.load(from: self.urlString)
        }.onDisappear {
            self.imageLoader.cancel()
        }
    }
    
    private var image: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!).resizable()
            } else {
                placeholder
            }
        }
    }
}
