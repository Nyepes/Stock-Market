//
//  ViewController.swift
//  Stock Market
//
//  Created by Nicolas Yepes on 7/9/19.
//  Copyright © 2019 Nicolas Yepes. All rights reserved.
//

import UIKit

class StockViewController: UITableViewController {
    
    var stocks = [[String: String]]()
    var symbols = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stock"
        let query = "https://financialmodelingprep.com/api/v3/company/profile/\(symbols["id"])"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    func parse(json: JSON) {
        for result in json["profile"].arrayValue {
            let mktCap = result["mktCap"].stringValue
            let price = result["price"].stringValue
            let compName = result["companyName"].stringValue
            let stock = ["mktCap" : mktCap, "price" : price, "companyName" : compName]
            stocks.append(stock)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated:  true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock["symbol"]
        cell.detailTextLabel?.text = stock["price"]
        return cell
    }
    
}

