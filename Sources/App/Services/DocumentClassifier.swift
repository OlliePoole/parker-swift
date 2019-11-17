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
    
    private static let amberWarnings = [
        "contacts", "location", "ip", "address", "bluetooth", "marketing", "advertising", "name", "gender"
    ]
    
    private static let greenWarnings: [String] = [] // TODO: later, or earlier....
    
    static func classify(response: NLPResponse) -> Classification {
        
        var redWarnings: [String] = []
        var amberWarnings: [String] = []
        var greenWarnings: [String] = []
        
        for phrase in response.documents.flatMap({ $0.keyPhrases }) {
            if redBlacklist.contains(phrase) {
                redWarnings.append(phrase)
            
            } else if amberWarnings.contains(phrase) {
                amberWarnings.append(phrase)
                
            } else if greenWarnings.contains(phrase) {
                greenWarnings.append(phrase)
            }
        }
        
        return Classification(redWarnings: redWarnings, amberWarnings: amberWarnings, greenWarnings: greenWarnings)
    }
    
}
