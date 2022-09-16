//
//  StockPurchaseView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/16.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct StockPurchaseView: View {
    @State var stock: StockDetail
    @StateObject var stockCurrentVM = StockCurrentViewModel()
    
    @EnvironmentObject var myStockModel: StockOrderViewModel
    @Environment(\.self) var env
    
    @StateObject var stockPurchaseVM = StockPurchaseViewModel()
    
    // MARK: MOVING PAGE WITHOUT NAVIGATIONVIEW
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var email = ""
    
    @State var bidAmount: String = ""
    @State private var showModal = false
    
    var body: some View {
        
        VStack(spacing: 40) {
            
            Text(stock.namekr)
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .padding()
            
            HStack {
                Text("$")
                
                if bidAmount == "" || bidAmount == "0." {
                    Text("0")
                        .font(.system(size: 50))
                } else {
                    Text(bidAmount)
                        .font(.system(size: 50))
                }
                
            }
            
            if bidAmount != "" && stockCurrentVM.currentStock.close != nil {
                Text("\(twoDecimalConverter(value: Double(bidAmount)! / twoDecimalConverter(value: stockCurrentVM.currentStock.close)) ) 주")
                    .font(.title3.bold())
                    .foregroundColor(.black)
            } else if bidAmount == "" || bidAmount == "0." {
                Text("0 주")
                    .font(.title3.bold())
                    .foregroundColor(.black)
            }
            
            Group {
                HStack {
                    Spacer()
                    Text("1")
                        .onTapGesture {
                            bidAmount += "1"
                        }
                    Spacer()
                    Text("2")
                        .onTapGesture {
                            bidAmount += "2"
                        }
                    Spacer()
                    Text("3")
                        .onTapGesture {
                            bidAmount += "3"
                        }
                    Spacer()
                }
                .foregroundColor(.green)
                
                HStack {
                    Spacer()
                    Text("4")
                        .onTapGesture {
                            bidAmount += "4"
                        }
                    Spacer()
                    Text("5")
                        .onTapGesture {
                            bidAmount += "5"
                        }
                    Spacer()
                    Text("6")
                        .onTapGesture {
                            bidAmount += "6"
                        }
                    Spacer()
                }
                .foregroundColor(.green)
                
                HStack {
                    Spacer()
                    Text("7")
                        .onTapGesture {
                            if bidAmount == "0" {
                                bidAmount = "7"
                            } else {
                                bidAmount += "7"
                            }
                        }
                    Spacer()
                    Text("8")
                        .onTapGesture {
                            if bidAmount == "0" {
                                bidAmount = "8"
                            } else {
                                bidAmount += "8"
                            }
                        }
                    Spacer()
                    Text("9")
                        .onTapGesture {
                            if bidAmount == "0" {
                                bidAmount = "9"
                            } else {
                                bidAmount += "9"
                            }
                        }
                    Spacer()
                }
                .foregroundColor(.green)
                
                HStack {
                    Spacer()
                    Text(".")
                        .padding(.leading, 10)
                        .onTapGesture {
                            let dotCount = bidAmount.filter{$0 == "."}.count
                            
                            if dotCount < 1 {
                                if bidAmount == "" {
                                    bidAmount += "0."
                                } else {
                                    bidAmount += "."
                                }
                            }
                            
                        }
                    Spacer()
                    Text("0")
                        .padding(.leading, 18)
                        .onTapGesture {
                            if bidAmount != "0" {
                                bidAmount += "0"
                            }
                        }
                    Spacer()
                    Text("⌫")
                        .padding(.leading, 5)
                        .offset(x: -5)
                        .onTapGesture {
                            if bidAmount != "" {
                                bidAmount.removeLast()
                            }
                        }
                    Spacer()
                }
                .foregroundColor(.green)
            }
                
            Button {
                
                stockPurchaseVM.fetchPurchase(owner: self.email, action: "buy", symbol: stock.symbol, price: twoDecimalConverter(value: stockCurrentVM.currentStock.close), quantity: twoDecimalConverter(value: (Double(bidAmount)! / twoDecimalConverter(value: stockCurrentVM.currentStock.close))))
                
                if Double(bidAmount)! > 0 {
                    self.showModal = true
                }

            } label : {
                Text("결제하기")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
            // 구매후 모달
            .sheet(isPresented: self.$showModal) {
                
                if bidAmount != "" || bidAmount != "0" || bidAmount != "0." {
                    PurchaseModalView(stock: stock, bidAmount: Double(bidAmount)!, stockAmount: (Double(bidAmount)! / stockCurrentVM.currentStock.close), showModal: $showModal)
                }
                
            }
            .frame(width: UIScreen.screenWidth * 0.6, height: 50)
            .background(.green)
            .clipShape(Capsule())
            
            
        }
        .font(.largeTitle.bold())
        .foregroundColor(.green.opacity(0.8))
        .onAppear {
            stockCurrentVM.fetch(query: stock.symbol)
        }
        .offset(y: -50)
        .onAppear {
            
            let currentUser = Auth.auth().currentUser
            self.email = (currentUser?.email)!

        }
    }
    
    func twoDecimalConverter(value: Double) -> Double {
        let convertedNumber = String(format: "%.02f", value)
        
        let twodigit = Double(convertedNumber)
        return twodigit!
    }
}

struct StockPurchaseView_Previews: PreviewProvider {
    static var stocks = ModelData().usstocks
    
    static var previews: some View {
        StockPurchaseView(stock: stocks[235])
            .environmentObject(StockOrderViewModel())
    }
}

struct PurchaseModalView: View {
    
    @State var stock: StockDetail
    @State var bidAmount: Double
    @State var stockAmount: Double
    @State private var timeRemaining = 10
    
    @Binding var showModal: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 30){
                
                Text("축하합니다!")
                    .font(.largeTitle.bold())
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 150))
                Text("\(stock.namekr) (\(stock.symbol))")
                HStack {
                    Text("결제금액: $")
                    Text("\(bidAmount)")
                }
                
                HStack {
                    Text("구매수량: ")
                    Text("\(stockAmount) 주")
                }
                
                Button {
                    self.showModal.toggle()
                    
                    // 여기다가 view 옮겨주는 function 필요
                } label: {
                    Text("닫기")
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.screenWidth * 0.6, height: 50)
                .background(.green)
                .clipShape(Capsule())
                
                Text("\(timeRemaining) 초 후에 자동으로 창이 사라집니다.")
                    .foregroundColor(.secondary)
                    .font(.callout)
                
            }
            .padding(50)
            .offset(y: -10)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer.upstream.connect().cancel()
                    
                }
            }
            .font(.title2.bold())

        }
    }
}
