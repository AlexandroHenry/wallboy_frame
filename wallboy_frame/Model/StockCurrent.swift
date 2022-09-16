//
//  StockCurrent.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import Foundation

struct StockCurrent: Codable {
    let date: String
    let open, high, low, close, adjclose: Double
    let volume: Int
    
    var convertedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertedDate: Date = dateFormatter.date(from: date)!
        return convertedDate
    }
    
    init() {
        date = "2000-01-01"
        open = 0
        high = 0
        low = 0
        close = 0
        adjclose = 0
        volume = 0
    }
}
