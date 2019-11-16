//
//  AnalysisRequest.swift
//  App
//
//  Created by Oliver Poole on 17/11/2019.
//

import Foundation
import Vapor

struct AnalysisRequest: Codable, Content {
    let content: String
}
