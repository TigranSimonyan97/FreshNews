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

class ImageLoader  {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    func load(from urlString: String ) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancellable?.cancel()
    }
}
