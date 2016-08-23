//
//  FeatureView.swift
//  Dobro jem
//
//  Created by Ziga Strgar on 22/08/16.
//  Copyright © 2016 Ziga Strgar. All rights reserved.
//

import UIKit

class FeatureView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}
