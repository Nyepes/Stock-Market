//
//  ViewController.swift
//  Stock Market
//
//  Created by Nicolas Yepes on 7/9/19.
//  Copyright © 2019 Nicolas Yepes. All rights reserved.
//

import UIKit

class StockViewController: UITableViewController {
    
    var stocks = [String]()
    var symbols = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = "https://financialmodelingprep.com/api/v3/company/profile/\(symbols)"
        print(query)
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data)
                    print("here?")
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    func parse(json: JSON) {
        var unFormattedmktCap = Double(json["profile"]["mktCap"].stringValue)!
        unFormattedmktCap /= 1000000000
        let mktCap = String(format: "Mkt Capital: %.2f Billions", unFormattedmktCap )
        let price = "Current Price: \(json["profile"]["price"].stringValue)"
        let compName = json["profile"]["companyName"].stringValue
        let description = json["profile"]["description"].stringValue
        let website =  (json["profile"]["website"].stringValue)
        stocks.append(compName)
        stocks.append(price)
        stocks.append(mktCap)
        stocks.append(description)
        stocks.append(website)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stocks[indexPath.row]
        return cell
    }
    
}
//let symbol = symbols[indexPath.row]
//cell.textLabel?.text = symbol["symbol"]
//cell.detailTextLabel?.text = symbol["price"]
////return cell
//articles[indexPath.row]["url"]!

