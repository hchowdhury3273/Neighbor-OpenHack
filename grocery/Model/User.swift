
import Foundation

struct User{
//    create shared singlton instance
//    static let sharedInstance = User()
    
    static var name: String?
    static var phoneNum: String?
    

//  MARK:- global arrays
    static var requestedList: [Item] = [Item]()
// map from firbase UID to delivery requested list
    static var deliveryList: [String: [Item]]?
}

