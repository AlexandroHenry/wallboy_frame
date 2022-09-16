//
//  StockInfoViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/16.
//

import Foundation

class StockInfoViewModel: ObservableObject {
    @Published var stockInfo = StockInfo()
    
    func fetch(symbol: String) {
        let urlString = "http://131.186.28.79/stockInfo/symbol=\(symbol)"
        
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let stockInfo = try JSONDecoder().decode(StockInfo.self, from: data)
                
                let info = stockInfo
                
                DispatchQueue.main.sync {
                    self!.stockInfo = info
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

