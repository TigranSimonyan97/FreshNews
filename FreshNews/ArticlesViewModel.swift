//
//  ArticlesViewModel.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI
import Combine

class ArticlesViewModel : ObservableObject {
    private let articleNetworkingManager = ArticlesNetworkingManager()
    private let errorHandler = RequestErrorHandler()
    
    @Published var articles = [ArticleDataModel]()
    
    private var articlesSubscriber: AnyCancellable?
    
    private var currentPageIndex = 1

    func fetchArticles() -> Void {
        articlesSubscriber = articleNetworkingManager.fetchArticles(inPage: currentPageIndex)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] (completion) in
                switch completion {
                case .failure(let error):
                    self.errorHandler.handle(error)
                case .finished: break
                }
                }) { [unowned self] fetchedArticles in
                
                    self.articles = self.articles + fetchedArticles.filter { $0.fields.thumbnailURLString != nil }
                    self.currentPageIndex += 1
                }

    }
}
