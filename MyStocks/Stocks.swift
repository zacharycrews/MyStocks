//
//  AllStocks.swift
//  MyStocks
//
//  Created by Zach Crews on 3/5/21.
//

import Foundation

class Stocks {
    var stocksArray: [Stock] = []
    var urlString = ""
    
    func getData(keyword: String, completed: @escaping()->()) {
        urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keyword)&apikey=\(APIKeys().alphaVantageKey)"
        guard let url = URL(string: urlString) else {
            print("ERROR: Couldn't create a URL from \(urlString)")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error)")
            }
            
            do {
                let matches = try JSONDecoder().decode(BestMatches.self, from: data ?? Data())
                self.stocksArray = matches.bestMatches
            } catch {
                print("JSON ERROR: \(error)")
            }
            completed()
        }
        task.resume()
    }
    
}
