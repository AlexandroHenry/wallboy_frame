//
//  StockPurchaseViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/13.
//

import Foundation

class StockPurchaseViewModel: ObservableObject {
    @Published var stockWallet = [StockWallet]()

    func fetchPurchase(owner: String, action: String, symbol: String, price: Double, quantity: Double) {
        
        let urlString = "http://131.186.28.79/stocktransaction/owner=\(owner)&action=\(action)&symbol=\(symbol)&price=\(price)&quantity=\(quantity)"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
    }
    
    func fetchLoading(owner: String) {
        
        let urlString = "http://131.186.28.79/stocktransaction/owner=\(owner)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let stockWallet = try JSONDecoder().decode([StockWallet].self, from: data)
                
                DispatchQueue.main.sync {
                    self!.stockWallet = stockWallet
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
