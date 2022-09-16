//
//  StockDetailView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI
import Charts

struct StockDetailView: View {
    @State var stock: StockDetail
    @StateObject var stockCurrentVM = StockCurrentViewModel()
    @StateObject var timeseriesVM = TimeSeriesViewModel()
    @StateObject var dailyStockVM = DailyStockViewModel()
    
    // MARK: CoreData 관련
    @Environment(\.self) var env
    @StateObject var stockOrderVM: StockOrderViewModel = .init()
    
    @State var currentTab: String = "3mo"
    
    // MARK: Gesture Properties
    @State var currentActiveItem: TimeSeries?
    @State var currentDailyActiveItem: DailyStock?
    @State var plotWidth: CGFloat = 0
    
    @State var content = "value"
    
    var body: some View {

        VStack {
            
            // Picker를 만들자
            
            if content == "value" {
                HStack(spacing: 20) {
                    Image("\(stock.symbol)_1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                    
                    VStack(alignment: .leading) {
                        Text(stock.namekr)
                            .font(.title.bold())
                        
                        Text(stock.longName)
                            .font(.footnote.bold())
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(twoDecimalConverter(value: stockCurrentVM.currentStock.close))")
                            .font(.title.bold())
                        
                        Text("\(twoDecimalConverter(value: (stockCurrentVM.currentStock.close - stockCurrentVM.currentStock.open))) (\(twoDecimalConverter(value: (stockCurrentVM.currentStock.close - stockCurrentVM.currentStock.open) / 100 ))%)")
                            .font(.footnote.bold())
                    }
                    .foregroundColor(stockCurrentVM.currentStock.close - stockCurrentVM.currentStock.open > 0 ? .green : .red)
                }
                
                if currentTab == "1w" || currentTab == "1mo" || currentTab == "3mo" || currentTab == "1y" || currentTab == "max" {
                    timeseriesLineChart()
                        .offset(y: -10)
                } else if currentTab == "1d" {
                    dailyLineChart()
                        .offset(y: -10)
                }
                
                HStack(spacing: 30) {
                    Spacer()
                    Text("1D")
                        .onTapGesture {
                            currentTab = "1d"
                            dailyStockVM.fetch(symbol: stock.symbol)
                        }
                    
                    Text("1W")
                        .onTapGesture {
                            currentTab = "1w"
                            timeseriesVM.fetch(symbol: stock.symbol, period: "5d", interval: "1d")
                        }
                    
                    Text("1M")
                        .onTapGesture {
                            currentTab = "1mo"
                            timeseriesVM.fetch(symbol: stock.symbol, period: "1mo", interval: "1d")
                        }
                    
                    Text("3M")
                        .onTapGesture {
                            currentTab = "3mo"
                            timeseriesVM.fetch(symbol: stock.symbol, period: "3mo", interval: "1d")
                        }
                    
                    Text("1Y")
                        .onTapGesture {
                            currentTab = "1y"
                            timeseriesVM.fetch(symbol: stock.symbol, period: "1y", interval: "1d")
                        }
                    
//                    Text("All")
//                        .onTapGesture {
//                            currentTab = "max"
//                            timeseriesVM.fetch(symbol: stock.symbol, period: "max", interval: "3mo")
//                        }
                    
                    Spacer()
                }
                .font(.callout)
                .foregroundColor(.green)
                .padding(.bottom, 10)
                
                VStack(spacing: 10) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("종가")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("\(twoDecimalConverter(value: stockCurrentVM.currentStock.close))")
                                .font(.title3.bold())
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("시가")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("\(twoDecimalConverter(value: stockCurrentVM.currentStock.open))")
                                .font(.title3.bold())
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("고가")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("\(twoDecimalConverter(value: stockCurrentVM.currentStock.high))")
                                .font(.title3.bold())
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("저가")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("\(twoDecimalConverter(value: stockCurrentVM.currentStock.low))")
                                .font(.title3.bold())
                        }
                        
                        Spacer()
                    }
                    
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("거래량")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            Text("\(stockCurrentVM.currentStock.volume)")
                                .font(.title3.bold())
                        }
                        
                        Spacer()
                    }
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
            } else {
                Text("Hello")
            }
            
            
            
            NavigationLink {
                StockPurchaseView(stock: stock)
                    .environmentObject(stockOrderVM)
            } label: {
                Text("Trade")
                    .foregroundColor(.white)
                    .font(.title3.bold())
            }
            .frame(width: UIScreen.screenWidth * 0.6, height: 50)
            .background(.green)
            .clipShape(Capsule())
            .onTapGesture{
                stockOrderVM.openEditStock.toggle()
            }
            
            Spacer()
        }
        .offset(y: -(UIScreen.screenHeight * 0.03))
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear{
            stockCurrentVM.fetch(query: stock.symbol)
            timeseriesVM.fetch(symbol: stock.symbol, period: "3mo", interval: "1d")
        }
        .padding()
        
    }
    
    @ViewBuilder
    func timeseriesLineChart() -> some View {
        let max = timeseriesVM.currentStock.max { item1, item2 in
            return item2.high > item1.high
        }?.high ?? 0
        
        let min = timeseriesVM.currentStock.min { item1, item2 in
            return item2.low > item1.low
        }?.low ?? 0
        
        
        Chart {
            ForEach(timeseriesVM.currentStock) { item in
                LineMark(
                    x: .value("Day", item.convertedDate.onlyDate!, unit: .day),
                    y: .value("Close", item.close)
                )
                .foregroundStyle(.green.gradient)
                
                
                if let currentActiveItem, currentActiveItem.id == item.id {
                    RuleMark(x: .value("Day", currentActiveItem.convertedDate.onlyDate!))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .annotation(position: .topLeading) {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text("Date:")
                                        .font(.caption)
                                    Text(dateformatConvertor(date: currentActiveItem.convertedDate))
                                }
                
                                HStack {
                                    Text("Close:")
                                        .font(.caption)
                                    
                                    Text(twoDecimalConverter(value: currentActiveItem.close))
                                        .font(.title3.bold())
                                }
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                            .offset(y: 50)
                        }
                }
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .chartOverlay(content: { proxy in
            GeometryReader { innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                // MARK: Getting Current Location
                                let location = value.location
                                
                                // Extracting Value From The Location
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    let day = calendar.dateComponents([.year, .month, .day], from: date.onlyDate!)
                                    
                                    if let currentItem = timeseriesVM.currentStock.first(where: {item in
                                        calendar.dateComponents([.year, .month, .day], from: item.convertedDate.onlyDate!) == day
                                    }) {
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded{ value in
                                self.currentActiveItem = nil
                            }
                    )
            }
        })
        .chartYScale(domain: (min-(min*0.1))...(max+(max*0.1)))
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .frame(height: UIScreen.screenHeight * 0.3)
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder
    func dailyLineChart() -> some View {
        let max = dailyStockVM.dailyStock.max { item1, item2 in
            return item2.high > item1.high
        }?.high ?? 0
        
        let min = dailyStockVM.dailyStock.min { item1, item2 in
            return item2.low > item1.low
        }?.low ?? 0
        
        Chart {
            ForEach(dailyStockVM.dailyStock) { item in
                LineMark(
                    x: .value("Day", item.convertedDate),
                    y: .value("Close", item.close)
                )
                .foregroundStyle(.green.gradient)
                
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .chartYScale(domain: (min-(min*0.01))...(max+(max*0.01)))
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .frame(height: UIScreen.screenHeight * 0.3)
        .padding(.horizontal, 5)
    }
    
    func dateformatConvertor(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func twoDecimalConverter(value: Double) -> String {
        let convertedNumber = String(format: "%.02f", value)
        return convertedNumber
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var stocks = ModelData().usstocks
    
    static var previews: some View {
        StockDetailView(stock: stocks[235])
    }
}
