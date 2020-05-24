

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
