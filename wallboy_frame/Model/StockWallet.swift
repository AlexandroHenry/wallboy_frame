//
//  StockWallet.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/13.
//

import Foundation

struct StockWallet: Codable, Identifiable {
    let id: String
    let date: String
    let owner, action, symbol, price: String
    let quantity: String
}

