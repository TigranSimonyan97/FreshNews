//
//  ImageLoader.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI
import Combine

typealias NetworkingDataTaskResult = Result<Data, RequestErrorHandler.RequestError>

class ImageLoader : ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    private let cacheManager = ImageCacheManager()
    private let restoreManager = ImageRestoreManager()
    
    func load(from urlString: String ) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let relativePath = url.deletingPathExtension().relativePath.replacingOccurrences(of: "/", with: "")
        if let storedImage = restoreManager.restoreData(from: relativePath) {
            self.image = storedImage
        } else {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { [unowned self] in
                    self.cacheManager.cache($0.data, in: relativePath)
                    return UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: self)
        }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancellable?.cancel()
    }
}
