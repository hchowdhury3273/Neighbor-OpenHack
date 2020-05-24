
import UIKit
import FirebaseAuth

protocol updateModelProtocol {
    func updateUserList(str: String)
}


class ProfileViewController: UITableViewController {
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var loginSegue:String = "profileVCToLoginVC"
    
    
    var items : [Item] = []
    var user = UserHub.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        print("viewdid laoded")
//        items = UserHub.sharedInstance.requestedList
//        self.itemTableView.reloadData()
        
        NotificationCenter.default.addObserver(forName: .vcOneAction, object: nil, queue: nil) { (notification) in
                  self.items = self.user.requestedList
                  self.itemTableView.reloadData()
              }

        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("appreaded sir")
//        NotificationCenter.default.addObserver(forName: .vcOneAction, object: nil, queue: nil) { (notification) in
//            self.items = self.user.requestedList
//            self.itemTableView.reloadData()
//        }
//    }
    
    func setUpView(){
        guard let name = User.name else {return}
        nameLabel.text = "Hello, " + name + "!"
    }
    
    

    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }
     
    

    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){}
    
    @IBAction func signOutButton(_ sender: Any) {
        print("SIGN out BOII")
               let firebaseAuth = Auth.auth()
               do {
                   try firebaseAuth.signOut()
                    performSegue(withIdentifier: self.loginSegue, sender: nil)
                    print("SIGN out done")
               } catch let signOutError as NSError {
                   print("ERror SIGN OUT")
               }
    }
  
}

//extension for table view delegates
extension ProfileViewController {
    //   MARK:- tableview delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        print("heres the count1 \(items.count)")
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "ItemView", bundle: nil), forCellReuseIdentifier: "ItemViewCell")
        
            let currItem = items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemViewCell") as! ItemViewCell
            cell.setItem(givenItem: currItem)
            return cell
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//            guard editingStyle == .delete else {return}
//            User.requestedList.remove(at: indexPath.row)
//            itemTableView.deleteRows(at: [indexPath], with: .fade)
//
//        }

}

//extension for view and animations
//extension ProfileViewController {
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//              let payNow = UIContextualAction(style: .normal, title: "Item Recieved") { (action, view, nil) in
//                  print("roar")
////                  self.items.remove(at: indexPath.row)
//                User.requestedList.remove(at: indexPath.row)
//                  self.itemTableView.deleteRows(at: [indexPath], with: .right)
//                  self.showAlert(title: "Item Delivered", message: "Transaction Has Been Completed")
//              }
//
//              payNow.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//
//              let config = UISwipeActionsConfiguration(actions: [payNow])
//              config.performsFirstActionWithFullSwipe = true
//              return config
//          }
//
//      override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//              let remove = UIContextualAction(style: .normal, title: "Remove") { (action, view, nil) in
//                     print("roar")
//                    User.requestedList.remove(at: indexPath.row)
//                     self.itemTableView.deleteRows(at: [indexPath], with: .left)
//                 }
//
//                 remove.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//
//                 let config = UISwipeActionsConfiguration(actions: [remove])
//                 config.performsFirstActionWithFullSwipe = true
//                 return config
//          }
//
//      //    ADD ITEMS FADE IN ANIMATION
//      override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//              cell.alpha = 0
//
//              UIView.animate(
//                  withDuration: 1,
//                  delay: 0.05 * Double(indexPath.row),
//                  animations: {
//                      cell.alpha = 1
//              })
//          }
//
//}

//extension UIView {
//    func fadeTransition(_ duration: CFTimeInterval) {
//        let animation = CATransition()
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        animation.type = CATransitionType.fade
//        animation.duration = duration
//        layer.add(animation, forKey: CATransitionType.fade.rawValue)
//    }
//}
