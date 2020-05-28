//
//  ImageLoader.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation
import Combine

typealias NetworkingDataTaskResult = Result<Data, RequestErrorHandler.RequestError>

class ImageLoader {
    
    func downloadImage(urlString: String) -> AnyPublisher<Data, RequestErrorHandler.RequestError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: RequestErrorHandler.RequestError.invalidURL(urlString)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                return try self.tryMapResponseToData(data: response.data, response: response.response)
        }.mapError {RequestErrorHandler.RequestError.map($0) }
        .eraseToAnyPublisher()
    }
}

extension ImageLoader {
    func tryMapResponseToData(data: Data, response: URLResponse) throws -> Data  {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestErrorHandler.RequestError.emptyResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw RequestErrorHandler.RequestError.incorrectStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}
