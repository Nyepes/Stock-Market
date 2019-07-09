//
//  ViewController.swift
//  Stock Market
//
//  Created by Nicolas Yepes on 7/9/19.
//  Copyright © 2019 Nicolas Yepes. All rights reserved.
//

import UIKit

class SymbolsViewController: UITableViewController {
    
    var symbols = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stock Market"
        let query = "https://financialmodelingprep.com/api/v3/company/stock/list"
        
    }


}

