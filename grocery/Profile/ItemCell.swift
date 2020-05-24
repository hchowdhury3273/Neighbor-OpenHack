//
//  ItemCell.swift
//  grocery
//
//  Created by Yasin Ehsan on 3/29/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    
    
    func setItem(givenItem: Item) {
        itemImage.image = givenItem.image
        nameLabel.text = givenItem.name
        priceLabel.text = givenItem.price
        
    }

}
