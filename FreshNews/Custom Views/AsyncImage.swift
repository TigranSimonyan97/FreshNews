//
//  AsyncImage.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/29/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View, Cacher: ImageCacheable, Retriever: ImageRetrievable>: View {
    
    @ObservedObject var viewModel: AsyncImageViewModel<Cacher, Retriever>
    
    let urlString: String
    private let placeholder: Placeholder?

    init(urlString: String, placeholder: Placeholder? = nil, viewModel: AsyncImageViewModel<Cacher, Retriever> ) {
        self.urlString = urlString
        self.placeholder = placeholder
        self.viewModel = viewModel
    }
    
    var body: some View {
        image.onAppear {
            self.viewModel.prepareImageLoader()
            self.viewModel.load(from: self.urlString)
        }.onDisappear {
            self.viewModel.cancel()
        }
    }
    
    private var image: some View {
        Group {
            if viewModel.image != nil {
                Image(uiImage: viewModel.image!).resizable()
            } else {
                placeholder
            }
        }
    }
}
