//
//  FactWebservice.swift
//  VirtusaTest
//
//  Created by Wael Saad on 26/4/18.
//  Copyright © 2018 nettrinity.com.au. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T>{
    case response(T)
    case error(error: Error)
}

// Fetch the Facts and Parse Them into the Model
class FactWebservice {
    typealias T = [Fact]
    
    // Set the end point for fetching the Facts
    internal var endPoint: String = WebserviceUrl.FactsURL
    

    // Parse the object and return an array of models
    internal func parseFeed(jsonData: [String : Any]) -> [Fact] {
        var dataArray: [Fact] = []
        for data in jsonData["rows"] as! [[String : Any]] {
            if shouldParseRow(data: data) {
                dataArray.append(Fact(jsonDictionary: data))
            }
        }
        return dataArray
    }
    
    // Parse the JSON object and return a model object from json
    internal func shouldParseRow(data: [String: Any]) -> Bool {
        guard (data["title"] as? String) != nil else {
            return false
        }
        return true
    }
    
    public func fetchFeed( completionHandler: @escaping (Result<T>) -> Void) {
        Alamofire.request(endPoint).responseString(completionHandler: { (responseData) in
            
            if let error = responseData.result.error {
                completionHandler(Result.error(error: error))
                return
            }
            
            if let data = responseData.result.value?.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                var jsonResult:Any
                do {
                    jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                }
                catch {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }
                
                guard let jsonData = jsonResult as? [String: Any] else {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }

                let feedReceived = self.parseFeed(jsonData: jsonData)
                completionHandler(Result.response(feedReceived))
            }
        })
    }
}
