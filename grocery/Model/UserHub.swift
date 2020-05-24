

import Foundation

class UserHub {
    static let sharedInstance = UserHub()
    
//    for homeVC table view
    var requestedList: [Item] = [Item]() {
        willSet {
        }
        didSet {
            NotificationCenter.default.post(name: .vcOneAction, object: self)
        }
    }
    
//    for shoppingVC table view
    var shoppingList: [GroceryList] = [GroceryList]() {
        willSet {
        }
        didSet {
            NotificationCenter.default.post(name: .shoppingList, object: self)
        }
    }
    
//    for feedVC table view
    var neighborList: [GroceryList] = [GroceryList]() {
        willSet {
            
        }
        didSet {
            
        }
    }
    
    
    
    private init() {
        listenDbChanges()
        let userList = GroceryList(name: User.name ?? "My List", groceryItems: requestedList)
        shoppingList.append(userList)
        listenNeighborLists()
        
    }
    
    func listenNeighborLists() {
//        neighborList.removeAll()
        var aggregateList: [GroceryList] = [GroceryList]()
        
        FirebaseManager.db.collectionGroup("users").addSnapshotListener{ (querySnapshot, err) in
            print("HELLO")
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("rorar")
                for (index, document) in querySnapshot!.documents.enumerated() {

//                    SUBCOLLECTION START
                    let id = document.documentID
                    
//                    if id == FirebaseManager.db_userUid {
//                        continue
//                    }
//                    aggregateList.insert(<#T##newElement: GroceryList##GroceryList#>, at: <#T##Int#>)
//                    self.neighborList[index].name = id
                    
                    let subCol = FirebaseManager.col_usersRef.document(id).collection("shoppingList").document("requestedItems")
                    print("ID IS")

                    subCol.getDocument { (document, error) in
                        
                        if let document = document, document.exists {
                            guard let data = document.data() else {
                              print("Document data was empty.")
                              return
                           }
//                              self.neighborList[index].groceryItems.insert(shopItem, at: 0)
//                            print(self.neighborList)
                            let personXReqList: [Item] = self.updateModel(data: data)
                            let personXGroceryList = GroceryList(name: id, groceryItems: personXReqList)
                            aggregateList.append(personXGroceryList)
                            print(aggregateList.count)
                        } else {
                            print("Document does not exist")
                        }
                    }

//                    SUBCOLLECTION END

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
             self.requestedList = self.updateModel(data: data)
             self.shoppingList[0].groceryItems = self.requestedList
           }
    
       }
       
       func updateModel(data: [String: Any]) -> [Item]{
        var newReqList: [Item] = [Item]()
            for output in data {
               if let itemDeets = output.value as? [String] {
                   let shopItem = Item(price: itemDeets[1], name: output.key, notes: itemDeets[0])
                newReqList.insert(shopItem, at: 0)
               }
           }
            return newReqList
       }
    
}
