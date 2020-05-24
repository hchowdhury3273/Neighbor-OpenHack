

import UIKit

class shoppingViewController: UITableViewController {
    @IBOutlet var itemTableView: UITableView!
    
    
    var shoppingList = [GroceryList]()
    let user = UserHub.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingList = UserHub.sharedInstance.shoppingList
        NotificationCenter.default.addObserver(forName: .shoppingList, object: nil, queue: nil) { (notification) in
            self.shoppingList = self.user.shoppingList
            self.itemTableView.reloadData()
        }
    }
    
    func setUpView(){
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
}

extension shoppingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList[section].groceryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//           print("papiaaa")
           
           tableView.register(UINib(nibName: "ItemView", bundle: nil), forCellReuseIdentifier: "ItemViewCell")
        let currItem = shoppingList[indexPath.section].groceryItems[indexPath.row]
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell
           
           cell.setItem(givenItem: currItem)
           return cell
       }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return shoppingList[section].name
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
    
//
//        override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//            let payNow = UIContextualAction(style: .normal, title: "Item Purchased") { (action, view, nil) in
//                print("roar")
//                self.objectsArray[indexPath.section].sectionObjects.remove(at: indexPath.row)
//                self.itemTableView.deleteRows(at: [indexPath], with: .right)
//            }
//
//            payNow.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//
//            let config = UISwipeActionsConfiguration(actions: [payNow])
//            config.performsFirstActionWithFullSwipe = true
//            return config
//        }
//
//        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let remove = UIContextualAction(style: .normal, title: "Remove") { (action, view, nil) in
//                   print("roar")
//                   self.objectsArray[indexPath.section].sectionObjects.remove(at: indexPath.row)
//                   self.itemTableView.deleteRows(at: [indexPath], with: .left)
//               }
//
//               remove.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//
//               let config = UISwipeActionsConfiguration(actions: [remove])
//               config.performsFirstActionWithFullSwipe = true
//               return config
//        }
//        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//            cell.alpha = 0
//
//            UIView.animate(
//                withDuration: 0.3,
//                delay: 0.1 * Double(indexPath.row),
//                animations: {
//                    cell.alpha = 1
//            })
//        }
//
}

