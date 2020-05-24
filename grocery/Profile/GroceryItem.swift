//
//  Item.swift
//  grocery
//
//  Created by Yasin Ehsan on 3/29/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import Foundation
import UIKit

struct GroceryItem {
    var image: UIImage
    
    init(image: UIImage){
        self.image = image
    }
}

extension GroceryItem {
    static let g1 = GroceryItem(image: UIImage(named: "looking") ?? UIImage())
    static let g2 = GroceryItem(image: UIImage(named: "onions") ?? UIImage())
    static let g3 = GroceryItem(image: UIImage(named: "bread-1") ?? UIImage())
    static let g4 = GroceryItem(image: UIImage(named: "broccoli-1") ?? UIImage())
}


