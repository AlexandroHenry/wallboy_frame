//
//  MyStockViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/16.
//

import Foundation
import SwiftUI
import CoreData

class StockOrderViewModel: ObservableObject {
    
    @Published var currentTab: String = "Stock"
    @Published var openEditStock: Bool = false
    
    @Published var myStockAvgPrice: Double = 0.0
    @Published var myStockDate: Date = Date()
    @Published var myStockIsSold: Bool = false
    @Published var myStockQuantity: Double = 0.0
    @Published var myStockSector: String = ""
    @Published var myStockSymbol: String = ""
    @Published var myStockType: String = "stock"

    @Published var editStock: StockOrder?

    func addStock(context: NSManagedObjectContext) -> Bool {
        
        var stockOrder: StockOrder!
        if let editStock = editStock {
            stockOrder = editStock
        } else {
            stockOrder = StockOrder(context: context)
        }
        
        stockOrder.type = myStockType
        stockOrder.quantity = myStockQuantity
        stockOrder.boughtDate = myStockDate
        stockOrder.symbol = myStockSymbol
        stockOrder.avgPrice = myStockAvgPrice
        stockOrder.sector = myStockSector
        stockOrder.isSold = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
}
