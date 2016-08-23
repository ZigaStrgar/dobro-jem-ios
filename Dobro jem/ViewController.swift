//
//  ViewController.swift
//  Dobro jem
//
//  Created by Ziga Strgar on 22/08/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var restaurants = [Restaurant]()
    var filtered = [Restaurant]()
    var searchMode: Bool = false
    var params = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        params["api_key"] = API_KEY
        initData()
        
        tableView.reloadData()
    }
    
    func initData(){
        Alamofire.request(.POST, "\(URL_API)\(RESTAURANTS)", parameters: params).validate().responseJSON {
            response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    self.restaurants = [Restaurant]()
                    for (_, rest): (String, JSON) in json["restaurants"] {
                        let restaurant = Restaurant()
                        restaurant.configRestaurant(rest)
                        self.restaurants.append(restaurant)
                        if self.restaurants.count % 20 == 0 {
                            self.tableView.reloadData()
                        }
                    }
                    self.tableView.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let restaurant = (searchMode) ? filtered[indexPath.row] : restaurants[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as? RestaurantCell {
            cell.configureCell(restaurant)
            return cell
        } else {
            let cell = RestaurantCell()
            cell.configureCell(restaurant)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchMode) ? filtered.count : restaurants.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            searchMode = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            searchMode = true
            let text = searchBar.text!.lowercaseString
            filtered = restaurants.filter({$0.name.lowercaseString.rangeOfString(text) != nil})
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

}

