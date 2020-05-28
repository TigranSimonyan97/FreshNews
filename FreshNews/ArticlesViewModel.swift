//
//  ArticlesViewModel.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation
import Combine

class ArticlesViewModel : ObservableObject {
    private let networkingManager = ArticlesNetworkingManager()
    private let errorHandler = RequestErrorHandler()
    private let dataParser = ArticleDataParser()
    
    private var currentPageIndex = 1
    
    @Published var articles = [ArticleDataModel]()
    
    private var articlesSubscriber: AnyCancellable?
    
    func articlesInPage() -> Void {
        articlesSubscriber = networkingManager.fetchArticles(inPage: currentPageIndex)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] (completion) in
                switch completion {
                case .failure(let error):
                    self.errorHandler.handle(error)
                case .finished: break
                }

                }, receiveValue: { [unowned self] fetchedArticles in
                    self.articles = self.articles + fetchedArticles
                    self.currentPageIndex += 1
            })
    }

}
