//
//  TimeSeries.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import Foundation

struct TimeSeries: Codable, Hashable,Identifiable {
    let id: String
    let date: String
    let open, high, low, close: Double
    let volume: Int
    var convertedDate: Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC")as TimeZone?
        
        let convertedDate: Date = dateFormatter.date(from: date)!
        return convertedDate
    }
}

// MARK: - DailyStockElement
struct DailyStock: Codable, Hashable, Identifiable {
    let id: String
    let date: String
    let open, high, low, close: Double
    let adjclose: Double
    let volume: Int

    var convertedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let convertedDate: Date = dateFormatter.date(from: date)!
        return convertedDate
    }
}
