
import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

class ItemFormViewController: UIViewController {
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpViews()
    }
    
    func setUpViews(){
        itemNameTextField.delegate = self
        notesTextField.delegate = self
        priceTextField.delegate = self
    }
    
    @IBAction func sendReqBtn(_ sender: Any) {
//        error check if field not empty oyh4erwise throw error
        guard let itemName = itemNameTextField.text else {return}
        guard let itemPrice = priceTextField.text else {return}
        guard let itemNotes = notesTextField.text else {return}
        if itemNameTextField.text == itemNameTextField.text{
            FirebaseManager.doc_reqListRef.setData([itemName :[
                itemNotes,
                "$" + itemPrice
                ]],merge: true)
        }else{
            print("empty input")
        }
        
//        let city = City(name: "Los Angeles",
//                        state: "CA",
//                        country: "USA",
//                        isCapital: false,
//                        population: 5000000)
        
        let item = Item(price: itemPrice, name: itemName)
        let duce = ["reqLis": item]

        do {
            
            let docRef = FirebaseManager.doc_userRef
//
            try FirebaseManager.doc_userRef.setData(from: [ itemName :[
            item, item
            ]],merge: true)
            
//            try FirebaseManager.doc_userRef.updateData(from: [
//                "reqList": FieldValue.arrayUnion([item])
//            ])
            
//            docRef.setData([
//                "regions": ["west_coast", "socal"]
//            ])
//            docRef.updateData([
//                "regions": FieldValue.arrayUnion([itemName])
//            ])
//            docRef.updateData([
//                "reqList": FieldValue.arrayUnion([["name": itemName, "price": itemPrice]])
//            ])
//            docRef.u
            
            
//              explore other encolable update fields options
//            docRef.setd
            
            
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }

        

       
               
    }
    
}

extension ItemFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemNameTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        print("return tapped")
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        any keybaord offset if needed
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        remove any offset if was added
        
    }
    
}
