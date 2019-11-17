//
//  DescriptionResolver.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation

struct DescriptionResolver {
    
    static func resolveDescripton(for item: String) -> String? {
        
        switch item {
        case "microphone": return "Be aware this website may access your device’s microphone to record audio in order to serve you content on their platform."
        case "bank": return "By using this website you may be granting access to your banking data, such as your balance and transactions."
        case "call": return "By using this website/service you are granting access to calling functions on your device, the application may start calls on your behalf."
        case "photos": return "By using this website you may be agreeing to grant access to your device’s photo library."
        case "media": return "This website may record, store and access your video and audio files."
        case "files": return "By using this website you may be granting access to your device’s file system, such as documents, photos and media files. "
        case "camera": return "This application may use your camera to perform its functions"
        case "messages": return "This application may access your device’s messages"
        
        case "contacts": return "This application may access your device’s contacts."
        case "location": return "This application may access your device’s GPS location."
        case "ip": return "This application accesses your computer’s unique address to identify your device from others."
        case "address": return "This application may ask you for your home or work address to sign up."
        case "bluetooth": return "This application may use your device’s short distance wireless capabilities to transfer data."
        case "marketing": return "By signing up to this website be aware that you may receive marketing materials from them in the future."
        case "advertising": return "By signing up and using this website, you may receive adverts on other platforms related to your activity on this website."
        case "name": return "This application will use your name to identify you after you sign up."
        case "gender": return "This application may require you enter your gender in order to serve personalised content."
        
        default:
            return nil
        }
        
    }
    
}
