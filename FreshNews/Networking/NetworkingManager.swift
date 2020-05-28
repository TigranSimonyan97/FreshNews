//
//  NetworkingManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation
import Combine

typealias NetworkingDataTaskResult = Result<Data, RequestErrorHandler.RequestError>

class NetworkingManager {
    private let BASE_URL = "https://content.guardianapis.com/search?api-key=c852c34d-5488-4340-9cfa-91811ca3c4dd&"
    
    func executeDataTask(withURLString: String) -> URLSession.DataTaskPublisher? {
        
        let urlString = "\(BASE_URL)\(withURLString)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let dataTask = session.dataTaskPublisher(for: request)
        return dataTask
    }
}

extension NetworkingManager {

    //TODO:
    //Add Image downloading
}
