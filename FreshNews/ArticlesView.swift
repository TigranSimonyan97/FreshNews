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
            ScrollView {
                VStack {
                    ForEach(viewModel.articles) { article in
                        ArticleItemView(article: article)
                    }
                    Button("More") {
                        self.viewModel.articlesInPage()
                    }
                }
                .frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center)
                .navigationBarTitle("Articles")
            }
        }
    }
}

struct ArticleItemView : View {
    var article: ArticleDataModel
    var body: some View {
        HStack(spacing: imageAndTextsSpaceing) {
            Group {
                if article.fields.thumbnailURLString != nil {
                    AsyncImage(urlString: article.fields.thumbnailURLString!, placeholder: PlaceholderImage())
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
            
            VStack(alignment: .leading, spacing: textSpaceing) {
                Text(article.fields.title).font(.headline)
                Text(article.shortBody).font(.body)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding([.leading, .trailing])
    }
    
    let imageCornerRadius: CGFloat  = 50
    let imageSideSize: CGFloat = 100
    let textSpaceing: CGFloat = 10
    let imageAndTextsSpaceing: CGFloat = 20
    let imageStrokeLineWidth: CGFloat = 3
    let imagePadding: CGFloat = 5
}

struct PlaceholderImage : View {
    var body: some View {
        Image("someimagehere").resizable().frame(width: 100, height: 100, alignment: .center).cornerRadius(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
