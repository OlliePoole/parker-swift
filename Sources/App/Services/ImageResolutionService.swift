//
//  ImageResolutionService.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation

struct ImageResolutionService {
    
    static func resolve(for category: String) -> String? {
     
        switch category {
        case "microphone": return "https://image.flaticon.com/icons/svg/25/25682.svg"
        case "bank": return "https://image.flaticon.com/icons/svg/66/66455.svg"
        case "call": return "https://image.flaticon.com/icons/svg/126/126341.svg"
        case "photos": return "https://image.flaticon.com/icons/svg/149/149637.svg"
        case "media": return "https://image.flaticon.com/icons/svg/149/149090.svg"
        case "files": return "https://image.flaticon.com/icons/svg/149/149877.svg"
        case "camera": return "https://image.flaticon.com/icons/svg/149/149641.svg"
        case "messages": return "https://image.flaticon.com/icons/svg/60/60800.svg"
        
        case "contacts": return "https://image.flaticon.com/icons/svg/157/157306.svg"
        case "location": return "https://image.flaticon.com/icons/svg/447/447031.svg"
        case "ip": return "https://image.flaticon.com/icons/svg/149/149240.svg"
        case "address": return "https://image.flaticon.com/icons/svg/69/69524.svg"
        case "bluetooth": return "https://image.flaticon.com/icons/svg/61/61089.svg"
        case "marketing": return "https://image.flaticon.com/icons/svg/1006/1006585.svg"
        case "advertising": return "https://image.flaticon.com/icons/svg/263/263126.svg"
        case "name": return "https://image.flaticon.com/icons/svg/942/942799.svg"
        case "gender": return "https://image.flaticon.com/icons/svg/505/505972.svg"
        
        default:
            return nil
        }
    }
    
}
