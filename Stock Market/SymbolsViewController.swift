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
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data)
                parse(json: json)
                return
            }
        }
        loadError()
    }
    func parse(json: JSON) {
        for result in json["symbolsList"].arrayValue {
            let id = result["symbol"].stringValue
            let price = result["price"].stringValue
            let symbol = ["symbol" : id, "price" : price]
            symbols.append(symbol)
            
            
        }
        tableView.reloadData()
    }
    func loadError() {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated:  true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symbols.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let symbol = symbols[indexPath.row]
        cell.textLabel?.text = symbol["name"]
        cell.detailTextLabel?.text = symbol["price"]
        return cell
    }
    
}

