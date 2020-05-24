
import UIKit

class ListHeaderViewCell: UITableViewCell {
    
    @IBOutlet var nameLebel: UILabel!
    @IBOutlet var pfpImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItem(name: String){
        nameLebel.text = name
    }
    
}
