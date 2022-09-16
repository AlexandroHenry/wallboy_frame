//
//  MyAssetView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct MyAssetView: View {
    
    @StateObject var stockPurchaseVM = StockPurchaseViewModel()
    
    @State var email = ""
    
    var body: some View {
        NavigationView {
            ScrollView{
                ForEach(stockPurchaseVM.stockWallet) { stock in
                    NavigationLink {
                        MyStockView(stock: stock)
                    } label: {
                        OwnStockRowView(stock: stock)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding()
            .padding(.bottom)
            .navigationTitle("보유 자산")
            .onAppear {
                let currentUser = Auth.auth().currentUser
                self.email = (currentUser?.email)!
                
                stockPurchaseVM.fetchLoading(owner: self.email)
            }
        }
    }
    
    @ViewBuilder
    func OwnStockRowView(stock: StockWallet) -> some View {
        VStack {
            HStack {
                Image("\(stock.symbol)_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(.horizontal, 20)
                    .offset(x: -10)
                
                VStack(alignment: .leading, spacing: 15){
                    Text(stock.symbol)
                    
                    HStack {
                        Text("보유주식량:")
                        Spacer()
                        Text("\(stock.quantity)")
                    }
                    
                    HStack {
                        Text("구매평균가:")
                        Spacer()
                        Text("\(stock.price)")
                    }
                    
                    HStack {
                        Text("현재 가치:")
                        Spacer()
                        Text("29192.212")
                    }
                }
                .foregroundColor(.black)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.secondary, lineWidth: 3)
            )
        .background(.white.opacity(0.5))
        }
    }
}

struct MyAssetView_Previews: PreviewProvider {
    static var previews: some View {
        MyAssetView()
    }
}
