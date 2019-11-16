//
//  StringBatchService.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation

struct StringBatchService {
    
    static func batch(string: String, batchLength: Int) -> [String] {
        
        let nsString = NSString(string: string)
        var index = 0
        var substrings: [String] = []
        let length = 5120
        
        while index < nsString.length {
            let splitRange = NSRange(location: index, length: (index + length
                < nsString.length) ? length : nsString.length - index)
            print(splitRange)
            let splitString = nsString.substring(with: splitRange)
            
            substrings.append(splitString)
            index += length
        }
        
        return substrings
    }
    
}
