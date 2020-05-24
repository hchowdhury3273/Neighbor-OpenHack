//
//  Item.swift
//  grocery
//
//  Created by Yasin Ehsan on 4/2/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import Foundation

struct Item: Codable {
    var price:String
    var name: String
    var notes:String?
//    var image: UIImage = UIImage(named: "onions") ?? UIImage()
    
    enum CodingKeys: String, CodingKey {
           case price
           case name
           case notes
       }
}

extension Item {
    static let item1 = Item(price: "hanibal", name: "roar")
}
