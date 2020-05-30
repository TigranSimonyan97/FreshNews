//
//  ArticlesListView.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import SwiftUI

struct ArticlesListView: View {
    @ObservedObject var viewModel = ArticlesViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.articles) { article in
                        ArticleItemView(article: article)
                    }
                    Button("More") {
                        self.viewModel.fetchArticles()
                    }
                }
                .frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center)
                .navigationBarTitle("Articles")
            }
        }.onAppear {
            self.viewModel.fetchArticles()
        }
    }
}

struct ArticleItemView : View {
    var article: ArticleDataModel
    var body: some View {
        HStack(spacing: imageAndTextsSpaceing) {
            ArticleImageView(article: article,
                             cacher: ImageCacheManager(directory: "articles", imageRelativePath: article.fields.thumbnailURLString!),
                             retriever: ImageRetrieveManager(directory: "articles", imageRelativePath: article.fields.thumbnailURLString!))
            VStack(alignment: .leading, spacing: textSpaceing) {
                Text(article.fields.title).font(.headline)
                Text(article.shortBody).font(.body)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding([.leading, .trailing])
    }
}

struct ArticleImageView : View {
    var article: ArticleDataModel
    var cacher: ImageCacheManager
    var retriever: ImageRetrieveManager
    
    var body: some View {
        return Group {
            if article.fields.thumbnailURLString != nil {
                AsyncImage(urlString: article.fields.thumbnailURLString!,
                                placeholder: PlaceholderImage(),
                                viewModel: AsyncImageViewModel(cacher: cacher, retriever: retriever))
                    .frame(width: imageSideSize, height: imageSideSize, alignment: .center)
                    .cornerRadius(imageCornerRadius)
                    .padding(imagePadding)
                    .overlay(
                        RoundedRectangle(cornerRadius: imageCornerRadius)
                            .stroke(Color.blue, lineWidth: imageStrokeLineWidth)
                )
            } else {
                PlaceholderImage()
            }
        }
    }
}

private let imageCornerRadius: CGFloat  = 50
private let imageSideSize: CGFloat = 100
private let textSpaceing: CGFloat = 10
private let imageAndTextsSpaceing: CGFloat = 20
private let imageStrokeLineWidth: CGFloat = 3
private let imagePadding: CGFloat = 5

struct PlaceholderImage : View {
    var body: some View {
        Image("someimagehere").resizable().frame(width: 100, height: 100, alignment: .center).cornerRadius(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesListView()
    }
}
