//
//  StockDetail.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import Foundation
import SwiftUI

struct StockDetail: Hashable, Codable, Identifiable {
    var id: Double
    var symbol: String
    var sector: String
    var industry: String
    var website: String
    var country: String
    var state: String
    var zip: String
    var longName: String
    var description: String
    var address1: String
    var namekr: String
    var descriptionkr: String
    var market: String
    var isFavorite: Bool
    
    var image: Image {
        Image(symbol)
    }
}
