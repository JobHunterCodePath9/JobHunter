//
//  SignUpViewController.swift
//  JobHunter
//
//  Created by Sunny Yu on 10/23/22.
//

import UIKit
import Parse
import AlamofireImage

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onUploadResume(_ sender: Any) {
        
        
    }
    @IBAction func onRegister(_ sender: Any) {

        var username = self.nameText.text
        var password = self.passwordText.text
        var email = self.emailText.text
       
        if (email!.isEmpty || username!.isEmpty || password!.isEmpty) {
            self.displayAlert(withTitle: "Error", message: "All fields are required")
        }
        let user = PFUser()
                
        user.email = email
        user.password = password
        user.username = username
        
       
        user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.displayAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                    self.displayAlert(withTitle: "Success", message: "Account has been successfully created")
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        }
        // neef fix: should display msg then perfom segue, login should check if user exist rather than auto sign in 
        //self.performSegue(withIdentifier: "signinSegue", sender: nil)
                
    }
    
    func displayAlert(withTitle title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "Ok", style: .default)
           alert.addAction(okAction)
           self.present(alert, animated: true)
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
