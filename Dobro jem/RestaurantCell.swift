//
//  RestaurantCell.swift
//  Dobro jem
//
//  Created by Ziga Strgar on 22/08/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import UIKit
import MapKit

class RestaurantCell: UITableViewCell {
    
    enum ActivityColor: Int {
        case Closed = 0xFF0000
        case Opened = 0x3ADB76
        case Undefined = 0xF0AD4E
    }
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantComments: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restaurantPrice: UILabel!
    
    @IBOutlet weak var restaurantActivity: FeatureView!
    @IBOutlet weak var pizzaFeature: FeatureView!
    @IBOutlet weak var vegiFeature: FeatureView!
    @IBOutlet weak var bonusFeautre: FeatureView!
    @IBOutlet weak var saladFeature: FeatureView!
    @IBOutlet weak var lunchFeature: FeatureView!
    @IBOutlet weak var deliveryFeature: FeatureView!
    @IBOutlet weak var weekendFeature: FeatureView!
    @IBOutlet weak var disabilityFeature: FeatureView!
    @IBOutlet weak var fastFoodFeature: FeatureView!
    
    var features = [FeatureView]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        features.append(pizzaFeature)
        features.append(vegiFeature)
        features.append(bonusFeautre)
        features.append(saladFeature)
        features.append(lunchFeature)
        features.append(deliveryFeature)
        features.append(weekendFeature)
        features.append(disabilityFeature)
        features.append(fastFoodFeature)
        
        for feature in features {
            feature.hidden = true
        }
        
        self.layoutMargins = UIEdgeInsetsZero
    }

    func configureCell(restaurant: Restaurant, location: CLLocationCoordinate2D) {
        restaurantName.text = restaurant.name
        restaurantPrice.text = restaurant.price
        restaurantAddress.text = restaurant.formatedAddress
        if let comments = restaurant.comments {
            restaurantComments.text = "\(comments)"
        }
        restaurantDistance.text = restaurant.humanizeDifference(location)
        if let rating = restaurant.rating {
            restaurantRating.text = "\(rating)"
        }
        
        if let opened = restaurant.isOpened() {
            switch opened {
            case true:
                restaurantActivity.backgroundColor = UIColor(netHex: ActivityColor.Opened.rawValue)
            case false:
                restaurantActivity.backgroundColor = UIColor(netHex: ActivityColor.Closed.rawValue)
            }
        } else {
            restaurantActivity.backgroundColor = UIColor(netHex: ActivityColor.Undefined.rawValue)
        }
        
        showFeatures(restaurant)
    }
    
    func showFeatures(restaurant: Restaurant) {
        for feature in features {
            feature.hidden = true
        }
        for feature in restaurant.features {
            features[feature-1].hidden = false
        }
    }

}
