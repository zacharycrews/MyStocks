//
//  AllStocks.swift
//  MyStocks
//
//  Created by Zach Crews on 3/5/21.
//

import Foundation

struct BestMatches: Codable {
    var bestMatches: [Stock]
}

struct Stock: Codable {
    var symbol: String?
    var name: String?
    
    private enum CodingKeys : String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
    }
}
