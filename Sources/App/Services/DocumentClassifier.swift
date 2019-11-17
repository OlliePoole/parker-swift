//
//  DocumentClassifier.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation

struct DocumentClassifier {
    
    struct Classification {
        var redWarnings: [String]
        var amberWarnings: [String]
        var greenWarnings: [String]
    }
    
    private static let redBlacklist = [
        "microphone", "bank", "call", "photos", "media", "files", "camera", "messages"
    ]
    
    private static let amberBlacklist = [
        "contacts", "location", "ip", "address", "bluetooth", "marketing", "advertising", "name", "gender"
    ]
    
    private static let greenBlacklist: [String] = [] // TODO: later, or earlier....
    
    static func classify(response: NLPResponse) -> Classification {
        
        var redWarnings: [String] = []
        var amberWarnings: [String] = []
        var greenWarnings: [String] = []
        
        var formattedPhrases: [String] = []
        for phrase in response.documents.flatMap({ $0.keyPhrases }) {
            let split = phrase.split(separator: " ")
            
            let filteredStrings = split.map { String($0) }.filter { $0.count > 3 }
            formattedPhrases.append(contentsOf: filteredStrings)
        }
        
        for phrase in formattedPhrases {
            if redBlacklist.contains(phrase) && !redWarnings.contains(phrase) {
                redWarnings.append(phrase)
            
            } else if amberBlacklist.contains(phrase) && !amberWarnings.contains(phrase) {
                amberWarnings.append(phrase)
                
            } else if greenBlacklist.contains(phrase) {
                greenWarnings.append(phrase)
            }
        }
        
        return Classification(redWarnings: redWarnings, amberWarnings: amberWarnings, greenWarnings: greenWarnings)
    }
    
}
