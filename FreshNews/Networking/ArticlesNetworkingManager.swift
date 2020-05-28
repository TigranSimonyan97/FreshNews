//
//  ArticlesNetworkingManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation
import Combine

class ArticlesNetworkingManager {
    private let networkingManager = NetworkingManager()

    private let baseURLString = "https://content.guardianapis.com/search?api-key=c852c34d-5488-4340-9cfa-91811ca3c4dd&show-fields=bodyText,thumbnail,headline&show-tags=contributor&page-size=20&page="
    
    func fetchArticles(inPage page: Int) -> AnyPublisher<[ArticleDataModel], RequestErrorHandler.RequestError> {
        let urlString = "\(baseURLString)\(page)"
        let decoder = JSONDecoder()
        
        guard let url = URL(string: urlString) else {
            return Fail(error: RequestErrorHandler.RequestError.incorrectURL(urlString))
                        .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    throw RequestErrorHandler.RequestError.emptyResponse
                }
                
                guard httpResponse.statusCode == 200 else {
                    throw RequestErrorHandler.RequestError.incorrectStatusCode(httpResponse.statusCode)
                }
                
                return response.data
        }.tryMap { allData -> Data in
            guard let dict = try? JSONSerialization.jsonObject(with: allData, options: [.allowFragments]) as? [String: Any],
                let response = dict["response"] as? [String: Any],
                let result = response["results"],
                let articlesData = try? JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed) else {
                throw RequestErrorHandler.RequestError.emptyData
            }
            
            return articlesData
        } .decode(type: [ArticleDataModel].self, decoder: decoder)
        .mapError { RequestErrorHandler.RequestError.map($0) }
        .eraseToAnyPublisher()
    }
}
