//
//  StocksListViewController.swift
//  MyStocks
//
//  Created by Zach Crews on 3/5/21.
//

import UIKit

class StocksListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var directionLabel: UILabel!
    
    let stocks = Stocks()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Hide keyboard if we tap outside of field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStock" {
            let destination = segue.destination as! StockDetailViewController
            destination.stock = stocks.stocksArray[tableView.indexPathForSelectedRow!.row]
        }
    }
    

}

extension StocksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Returning stock count --> \(stocks.stocksArray.count)")
        return stocks.stocksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock", for: indexPath) as! StockTableViewCell
        cell.tickerLabel.text = stocks.stocksArray[indexPath.row].symbol ?? ""
        cell.nameLabel.text = stocks.stocksArray[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

extension StocksListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            tableView.isHidden = true
            directionLabel.isHidden = false
            return
        }
        
        stocks.getData(keyword: searchText) {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.directionLabel.isHidden = true
                self.tableView.reloadData()
            }
        }
            
    }
}
