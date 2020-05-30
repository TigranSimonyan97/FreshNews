//
//  ArticleDataModel.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

struct ArticleDataModel : Decodable, Identifiable {
    
    var id: String
    var type: String
    var sectionId: String
    var sectionName: String
    var webURLString: String
    var fields: Field
    var tags: [Tag]
    
    var shortBody: String {
        let body = fields.body
        let offset = body.count > 100 ? 99 : body.count
        let index = body.index(body.startIndex, offsetBy: offset)
        return String(body.prefix(upTo: index))
    }
    
    var thumbnailRelativePath: String? {
        URL(string: fields.thumbnailURLString!)?.relativePath
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case type
        case sectionId
        case sectionName
        case webURLString = "webUrl"
        case fields
        case tags
    }
    
    struct Field : Decodable {
        var title: String
        var thumbnailURLString: String?
        var body: String
        
        enum CodingKeys: String, CodingKey {
            case title = "headline"
            case thumbnailURLString = "thumbnail"
            case body = "bodyText"
        }
    }
    
    struct Tag: Decodable {
        var id: String
        var type: String
        var webURLString: String
        var firstName: String?
        var lastName: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case type
            case webURLString = "webUrl"
            case firstName
            case lastName
        }
    }
}
