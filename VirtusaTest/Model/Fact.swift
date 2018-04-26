//
//  Facts.swift
//  VirtusaTest
//
//  Created by Wael Saad on 26/4/18.
//  Copyright © 2018 nettrinity.com.au. All rights reserved.
//

import Foundation

// Fact Json Object
struct Fact {
    let title: String
    let description: String?
    let imageHref: String?
    
    // Parse the JSON object and return a model object from json
    init(jsonDictionary: [String: Any]) {
        self.title = (jsonDictionary["title"] as? String)!
        self.description = (jsonDictionary["description"] as? String) ?? nil
        self.imageHref = (jsonDictionary["imageHref"] as? String) ?? nil
    }
}
