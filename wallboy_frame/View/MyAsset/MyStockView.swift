//
//  MyStockView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/15.
//

import SwiftUI

struct MyStockView: View {
    
    @State var stock: StockWallet
    @StateObject var seekingAlphaVM = SeekingAlphaViewModel()
    @StateObject var stockCurrentVM = StockCurrentViewModel()
    
    @StateObject var stockInfoVM = StockInfoViewModel()
    
    @State var showSafari = false
    
    var body: some View {
        NavigationView {

            List {
                
                VStack {
                    HStack {
                        Image("\(stock.symbol)_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                        VStack {
                            Text(stockInfoVM.stockInfo.shortName)
                            Text(stock.symbol)
                        }
                        
                    }
                    
                    Text(stockInfoVM.stockInfo.longBusinessSummary)
                    
                    HStack {
                        
                    }
                    
                    HStack {
                        Text("현재 가치")
                        Spacer()
                        Text(calculateCurrentValue(quantity: stock.quantity ,currentValue: stockCurrentVM.currentStock.close))
                    }
                    
                    HStack {
                        Text("보유량:")
                        Spacer()
                        Text(stock.quantity)
                    }
                }
                
                ForEach(seekingAlphaVM.items, id: \.self) { item in
                    Button{
                        showSafari.toggle()
                    } label: {
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                    }
                    .sheet(isPresented: $showSafari) {
                        SafariView(url: URL(string: item.link)!)
                    }
                }
            }
            .navigationTitle("테슬라")
           
        }
        .onAppear{
            seekingAlphaVM.loadData(symbol: stock.symbol)
            stockCurrentVM.fetch(query: stock.symbol)
            stockInfoVM.fetch(symbol: stock.symbol)
        }
    }
    
    func calculateCurrentValue(quantity: String, currentValue: Double) -> String {
        
        let total = Double(quantity)! * currentValue
        let totalString = String(format: "%.02f", total)
        
        return totalString
    }
    
    func twoDecimalConverter(value: Double) -> Double {
        let convertedNumber = String(format: "%.02f", value)
        
        let twodigit = Double(convertedNumber)
        return twodigit!
    }
}

struct MyStockView_Previews: PreviewProvider {
    static var previews: some View {
        MyStockView(stock: StockWallet(id: "0000", date: "2022-01-21", owner: "tester", action: "buy", symbol: "AAPL", price: "129.12", quantity: "12122"))
    }
}
