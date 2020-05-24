
import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    var dummyUserCodes : [String: String] = [
           "av" : "avocado",
           "b" : "bread",
           "ap" : "apple",
           "c" : "chips",
           "m" : "milk",
           "cr" : "carrot"
        
       ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(givenItem: Item) {
//          itemImage.image = givenItem.image
          itemImage.image = UIImage(named: "chips") ?? UIImage()
          itemName.text = givenItem.name
          itemPrice.text = givenItem.price
          
      }

}
