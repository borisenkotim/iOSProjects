

import UIKit

class AddFoodViewController: UIViewController, UITextFieldDelegate {
    
    var messageFromFirstView: String?
    var addedFoodLabel: String? = "-1"
    @IBOutlet var userInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = messageFromFirstView
        self.userInput.delegate = self
    }

    @IBOutlet weak var message: UILabel!
    
    var buttonTapped: String? = "none"
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        buttonTapped = "save"
        addedFoodLabel = userInput.text
        performSegue(withIdentifier: "unwindOnBothClicks", sender: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        buttonTapped = "cancel"
        performSegue(withIdentifier: "unwindOnBothClicks", sender: nil)
    }
    
    @IBAction func editTextClicked(_ sender: UITextField) {
        // when user starts typing
        print("editText Func Got Called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // makes keyboard dissappear when user taps return
        self.view.endEditing(true)
        return false
    }
}
