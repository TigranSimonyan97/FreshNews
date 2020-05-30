//
//  AsyncImageViewModel.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/30/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI
import Combine

class AsyncImageViewModel<Cacher: ImageCacheable, Retriever: ImageRetrievable>  : ObservableObject {
    @Published var image: UIImage?
    
    private let imageLoader = ImageLoader()
    private let cacher: Cacher
    private let retriever: Retriever
    private var imageLoaderSubscriber: AnyCancellable?
    
    init(cacher: Cacher, retriever: Retriever) {
        self.cacher = cacher
        self.retriever = retriever
    }
    
    func prepareImageLoader() {
        self.imageLoaderSubscriber = imageLoader.$image.sink { [unowned self] in
            self.image = $0
            if let loadedImage = $0 {
                self.cacher.cache(loadedImage)
            }
        }
    }
    
    func load(from urlString: String) {
        if let image = retriever.retrieveData() {
            self.image = image
        } else {
            imageLoader.load(from: urlString)
        }
    }
    
    func cancel() {
        imageLoader.cancel()
    }
}
