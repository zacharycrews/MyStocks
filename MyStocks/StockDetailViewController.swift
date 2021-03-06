//
//  StockDetailViewController.swift
//  MyStocks
//
//  Created by Zach Crews on 3/5/21.
//

import UIKit

class StockDetailViewController: UIViewController {
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var stock: Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tickerLabel.text = stock.symbol ?? ""
        nameLabel.text = stock.name ?? ""
        
        // Do any additional setup after loading the view.
    }

}
