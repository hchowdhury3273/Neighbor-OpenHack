

import Foundation

class UserHub {
    static let sharedInstance = UserHub()
    
//    for homeVC table view
    var requestedList: [Item] = [Item]() {
        willSet {
            let list = UserHub.sharedInstance.requestedList
//            print("willset \(list.count)")
        }
        didSet {
            let list = UserHub.sharedInstance.requestedList
//            print("didset \(list.count)")
            NotificationCenter.default.post(name: .vcOneAction, object: self)
        }
    }
    
//    for shoppingVC table view
    var shoppingList: [GroceryList] = [GroceryList]() {
        willSet {
//            print("CHNAGEING SHOP LIST")
        }
        didSet {
            NotificationCenter.default.post(name: .shoppingList, object: self)
        }
    }
    
    var deliveryList: [GroceryList] = [GroceryList]()
    
    
    private init() {
        listenDbChanges()
        let userList = GroceryList(name: User.name ?? "My List", groceryItems: requestedList)
        shoppingList.append(userList)
        getDocOnce()
    }
    
    func getDocOnce() {
        FirebaseManager.col_usersRef.getDocuments() { (querySnapshot, err) in
            print("HELLO")
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

//                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
       
   func listenDbChanges(){
   //        sync up model with firebase here
           FirebaseManager.doc_reqListRef
           .addSnapshotListener { documentSnapshot, error in
             guard let document = documentSnapshot else {
               print("Error fetching document: \(error!)")
               return
             }
             guard let data = document.data() else {
               print("Document data was empty.")
               return
             }
//             print("Current data: \(data.keys)")
             self.updateModel(data: data)
           }
       }
       
       func updateModel(data: [String: Any]){
           requestedList.removeAll()
            for output in data {
               if let itemDeets = output.value as? [String] {
                   let shopItem = Item(price: itemDeets[1], name: output.key, notes: itemDeets[0])
                requestedList.insert(shopItem, at: 0)
               }
           }
            shoppingList[0].groceryItems = requestedList
       }
    
}
