//
//  SearchView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var searchText = ""
    
    var filteredStocks: [StockDetail] {
        modelData.usstocks.filter { stock in
            stock.symbol.contains(searchText) || stock.longName.contains(searchText) || stock.namekr.contains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredStocks) { stock in
                    
                    NavigationLink {
                        StockDetailView(stock: stock)
                    } label: {
                        HStack {
                            Image("\(stock.symbol)_1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading){
                                Text(stock.namekr)
                                    .font(.title2)
                                Text(stock.longName)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("종목 검색")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData())
    }
}
