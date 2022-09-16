//
//  StockCurrentViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import Foundation

class StockCurrentViewModel: ObservableObject {
    @Published var currentStock = StockCurrent()
    
    func fetch(query: String) {
        let urlString = "http://131.186.28.79/currentStock/symbol=\(query)"
        
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let stockCurrent = try JSONDecoder().decode(StockCurrent.self, from: data)
                
                let stockValue = stockCurrent
                
                DispatchQueue.main.sync {
                    self!.currentStock = stockValue
                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
