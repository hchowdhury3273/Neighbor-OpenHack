//
//  feedViewController.swift
//  grocery
//
//  Created by Helal Chowdhury on 3/29/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import UIKit

struct Objects{
    var sectionName: UIImage!
    var sectionObjects: [UIImage]!
}


class feedViewController: UITableViewController {
    /**NOTES
        - get all user collection data from firebaes databse
        - show as grocery list
        - if colelction uid eaul current user or user who already swiped...dont show else add to tablel view
        - create hastable is userHub for already swipes
     
        - use coable to add and read custom data objects
        - use the custom data objects from userhub as part of doc data in each user
        - this means instead of using shopping list as a colelction inside each user doc...we can be more cool
     
     
        
     */
    
    @IBOutlet var itemTableView: UITableView!
    
    
    var objectsArray = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsArray =
            [Objects(sectionName: UIImage(named: "yasin"), sectionObjects: [UIImage(named: "yasin")!,UIImage(named: "avocado")!,UIImage(named: "apple")!, UIImage(named: "lowfatMilk")!]),
            Objects(sectionName:UIImage(named: "rageeb"), sectionObjects: [UIImage(named: "rageeb")!,UIImage(named: "greenCabbage")!,UIImage(named: "yellowCorn")!, UIImage(named: "carrot")!]),
            Objects(sectionName: UIImage(named: "meng"), sectionObjects: [UIImage(named: "meng")!, UIImage(named: "orange")!,UIImage(named: "ribEyeSteak")!, UIImage(named: "strawberries")!]),
        ]
//        firebaseSnapshot()
//        reqListSnapshot()
        readAllDocsInCollection()
//        listenForChangeInCollection()
    }
    
    func listenForChangeInCollection(){
        FirebaseManager.db.collection("users")
            .addSnapshotListener { querySnapshot, error in
                
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            let cities = documents.map { $0["name"]! }
            print("Current cities in CA: \(cities)")
        }

    }
    
    
    
//    able to read changes for github
    func readAllDocsInCollection(){
        FirebaseManager.db.collectionGroup("users").addSnapshotListener{ (querySnapshot, err) in
            print("HELLO")
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("rorar")
                for document in querySnapshot!.documents {
                    
//                    subcillection start
                    let id = document.documentID
                    let subCol = FirebaseManager.col_usersRef.document(id).collection("shoppingList").document("requestedItems")
                    print("ID IS")
//                    snapshot here
                    subCol.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                        } else {
                            print("Document does not exist")
                        }
                    }
//                    subcollection end

//                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    
    
//    func reqListSnapshot(){
//        let docRef = FirebaseManager.doc_userRef
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
////                get one field in document
//                let property = document.get("reqList")
//
//                let result = Result {
//                  try property?.data(as: Item.self)
//                }
//                switch result {
//                case .success(let city):
//                    if let city = city {
//                        // A `City` value was successfully initialized from the DocumentSnapshot.
//                        print("City: \(city.name)")
//                    } else {
//                        // A nil value was successfully initialized from the DocumentSnapshot,
//                        // or the DocumentSnapshot was nil.
//                        print("Document does not exist")
//                    }
//                case .failure(let error):
//                    // A `City` value could not be initialized from the DocumentSnapshot.
//                    print("Error decoding city: \(error)")
//                }
//
//                print("Document data: \(property)")
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
    
    func firebaseSnapshot(){
        let docRef = FirebaseManager.doc_userRef
//        db.collection("cities").document("BJ")

        docRef.getDocument { (document, error) in
            // Construct a Result type to encapsulate deserialization errors or
            // successful deserialization. Note that if there is no error thrown
            // the value may still be `nil`, indicating a successful deserialization
            // of a value that does not exist.
            //
            // There are thus three cases to handle, which Swift lets us describe
            // nicely with built-in sum types:
            //
            //      Result
            //        /\
            //   Error  Optional<City>
            //               /\
            //            Nil  City
            let result = Result {
                try document?.data(as: Item.self)
            }
            switch result {
            case .success(let city):
                if let city = city {
                    // A `City` value was successfully initialized from the DocumentSnapshot.
                    print("City: \(city.name)")
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding city: \(error)")
            }
        }
    }
    
    

}

extension feedViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "item") as! UITableViewCell?
        cell?.imageView?.image = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> UIImage? {
        return objectsArray[section].sectionName
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let payNow = UIContextualAction(style: .normal, title: "Add To Cart") { (action, view, nil) in
            print("roar")
            self.objectsArray[indexPath.section].sectionObjects.remove(at: indexPath.row)
            self.itemTableView.deleteRows(at: [indexPath], with: .left)
            
        }
        
        payNow.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        let config = UISwipeActionsConfiguration(actions: [payNow])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.3,
            delay: 0.1 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }

}

