//
//  ArticlesView.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

struct ArticlesView: View {
    @ObservedObject var viewModel = ArticlesViewModel()
    var body: some View {
        NavigationView {
            VStack {
                ForEach(viewModel.articles) { article in
                    ArticleItemView(article: article)
                }
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center)
            .navigationBarTitle("Articles")
            .navigationBarItems(trailing:
                Button("Add") {
                    self.viewModel.articlesInPage()
                }
            )
        }
    }
}

struct ArticleItemView : View {
    var article: ArticleDataModel
    var body: some View {
        HStack(spacing: 20) {
            Image("someimagehere").resizable().frame(width: 100, height: 100, alignment: .center).cornerRadius(50)
            VStack(alignment: .leading, spacing: 10) {
                Text(article.fields.title).font(.title)
                Text(article.shortBody).font(.body)
            }
        }.frame(maxWidth: .infinity,
                alignment: .leading)
            .padding([.leading, .trailing])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
