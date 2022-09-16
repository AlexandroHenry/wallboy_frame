//
//  DailyStockViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import Foundation

class DailyStockViewModel: ObservableObject {
    @Published var dailyStock = [DailyStock]()
    
    func fetch(symbol: String) {
        
        let urlString = "http://131.186.28.79/dailyStock/symbol=\(symbol)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let stsDaily = try JSONDecoder().decode([DailyStock].self, from: data)
                
                DispatchQueue.main.sync {
                    self!.dailyStock = stsDaily
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
