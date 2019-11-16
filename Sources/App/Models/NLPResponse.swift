//
//  NLPResponse.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation
import Vapor

struct NLPResponse: Codable, Content {
    
    var documents: [Document]
    
    struct Document: Codable, Content {
        var id: String
        var keyPhrases: [String]
    }
}

struct NLPRequest: Codable, Content {
    
    var documents: [Document]
    
    struct Document: Codable, Content {
        var language: String
        var id: String
        var text: String
    }
}
