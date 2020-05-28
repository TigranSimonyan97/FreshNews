//
//  ArticleDataParser.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

struct ArticleDataParser : DataParser {
    typealias DataType = [ArticleDataModel]?
    
    func parse(data: Data) -> DataType {
        let decoder = JSONDecoder()
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
            let result = dictionary["results"],
            let jsonData = try? JSONSerialization.data(withJSONObject: result, options: []) else { return nil }
        return try? decoder.decode(DataType.self, from: jsonData)
    }
}
