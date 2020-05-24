
import Foundation

struct User{
//    create shared singlton instance
    static let sharedInstance = User()
    
    static var name: String?
    static var phoneNum: String?
    
    public init() {}
    
}

