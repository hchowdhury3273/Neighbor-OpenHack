
import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    
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
          itemImage.image = UIImage(named: "onions") ?? UIImage()
          itemName.text = givenItem.name
          itemPrice.text = givenItem.price
          
      }

}
