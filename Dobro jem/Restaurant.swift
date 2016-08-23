//
//  Restaurant.swift
//  Dobro jem
//
//  Created by Ziga Strgar on 22/08/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension Float {
    var rating: String {
        return "\(self)/5.0"
    }
}

class Restaurant {
    private var _name: String!
    private var _price: String!
    private var _address: String!
    private var _id: Int!
    private var _original_id: String!
    private var _city: String!
    private var _lat: Double!
    private var _lng: Double!
    private var _distance: String!
    private var _rating: [String: Float]!
    private var _comments: Int8!
    private var _timeRemaining: String!
    private var _weekdays: String!
    private var _saturdays: String!
    private var _sundays: String!
    private var _opened: Bool?
    private var _restaurantURL: String!
    private var _phones: [String]!
    private var _features: [Int]!
    private var _menus: Array<Array<String>>!
    
    var name: String {
        return _name
    }
    
    var address: String {
        return _address
    }
    
    var city: String {
        return _city
    }
    
    var formatedAddress: String {
        return "\(_address), \(_city)"
    }
    
    var price: String {
        return _price
    }
    
    var id: String {
        return "\(_id)"
    }
    
    var lat: Double {
        return _lat
    }
    
    var lng: Double {
        return _lng
    }
    
    var distance: String? {
        return _distance
    }
    
    var remaining: String {
        return _timeRemaining
    }
    
    var comments: Int8? {
        return _comments
    }
    
    var rating: Float? {
        return _rating["average"]
    }
    
    var ratings: [String: Float] {
        return _rating
    }
    
    var phones: [String] {
        return _phones
    }
    
    var menus: [[String]] {
        return _menus
    }
    
    var formatedRating: String {
        return "\(_rating)/5.0"
    }
    
    var features: [Int] {
        return _features
    }
    
    var weekdays: String {
        return _weekdays
    }
    
    var saturdays: String {
        return _saturdays
    }
    
    var sundays: String {
        return _sundays
    }
    
    func isOpened() -> Bool? {
        return _opened
    }
    
    init() {
        
    }
    
    func configRestaurant(json: JSON) {
        self._name = json["name"].string
        self._price = json["price"].string
        self._address = json["address"].string
        self._city = json["city"].string
        self._id = json["id"].int
        self._original_id = json["original_id"].string
        self._lat = json["lat"].double
        self._lng = json["lng"].double
        self._distance = json["distance"].string
        self._rating = [String: Float]()
        self._rating["average"] = json["rating"].float
        self._comments = json["comments"].int8
        self._opened = json["opened"].bool
        self._timeRemaining = json["time_remaining"].string
        self._phones = json["phones"].array?.filter({ $0.string != nil }).map({ $0.string! })
        self._features = json["features"].array?.filter({ $0.string != nil }).map({ Int($0.string!)! })
    }
    
    func downloadRestaurant(completed: DownloadComplete) {
        if self._menus == nil {
            if let nsurl = NSURL(string: _restaurantURL) {
                Alamofire.request(.POST, nsurl).validate().responseJSON(completionHandler: {
                    response in
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            self._weekdays = json["restaurant", "weekdays"].string
                            self._saturdays = json["restaurant", "saturdays"].string
                            self._sundays = json["restaurant", "sundays"].string
                            self._rating["quality"] = json["restaurant", "ratings", "quality"].float
                            self._rating["clean"] = json["restaurant", "ratings", "clean"].float
                            self._rating["ambient"] = json["restaurant", "ratings", "ambient"].float
                            self._rating["service"] = json["restaurant", "ratings", "service"].float
                            var menus = [[String]]()
                            for x in 0 ..< json["restaurant", "menus"].count {
                                menus.append((json["restaurant", "menus", x].array?.filter({ $0.string != nil }).map({ $0.string! }))!)
                            }
                            self._menus = menus
                            completed()
                        }
                    case .Failure(let error):
                        print(error)
                    }
                })
            }
        }
    }
    
    func numberToStars(grade: Float) -> String {
        var string: String = ""
        var i = Int(floor(grade)) - 1
        
        for _ in 0 ..< Int(floor(grade)) {
            string += "J"
        }
        
        let rest = grade - floor(grade)
        
        if rest >= 0.3 && rest <= 0.7 && i < 5 {
            string += "L"
            i += 1
        } else if rest > 0.7 && i < 5 {
            string += "J"
            i += 1
        } else {
            string += "M"
            i += 1
        }
        
        while i < 5 {
            string += "M"
            i += 1
        }
        
        return string
    }
}