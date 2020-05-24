
import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var loginSegue:String = "nameVCtoLoginVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
   func setUpView(){
    nameTextField.delegate = self
    }

}

extension NameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let name = nameTextField.text else{return false}
        User.name = name
        nameTextField.resignFirstResponder()
        self.performSegue(withIdentifier: self.loginSegue, sender: nil)
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        any keybaord offset if needed
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        remove any offset if was added
        
    }
}
