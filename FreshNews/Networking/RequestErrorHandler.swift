//
//  RequestErrorManager.swift
//  FreshNews
//
//  Created by Tigran Simonyan on 5/22/20.
//  Copyright © 2020 Scriptomania. All rights reserved.
//

import Foundation

class RequestErrorHandler {
    
    func handle(_ error: RequestError) {
        switch error {
        case .invalidURL(let urlString):
            print("Computed URL string is incorrect. URL string is - \(urlString)")
        case .requestFail(let localizedDescription):
            print("There where error during data task execution. Error localizedDescription is - \(localizedDescription)")
        case .emptyResponse:
            print("Response is empty")
        case .incorrectStatusCode(let statusCode):
            print("Status code is incorrect. Status code - \(statusCode)")
        case .emptyData:
            print("Data is empty")
        case .emptyImage:
            print("Impossible to get image from url")
        case .other(let error):
            print("Not a RequestError. Error localizedDescription is \( error.localizedDescription)")
        }
    }
    
    enum RequestError : Error {
        case invalidURL(String)
        case requestFail(String)
        case emptyResponse
        case incorrectStatusCode(Int)
        case emptyData
        case emptyImage
        case other(Error)
        
        static func map(_ error: Error) -> RequestError {
          return (error as? RequestError) ?? .other(error)
        }
    }
}
