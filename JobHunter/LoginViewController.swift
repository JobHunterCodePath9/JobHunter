//
//  LoginViewController.swift
//  JobHunter
//
//  Created by Sunny Yu on 10/23/22.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //for some reason I could still perform the segue without putting an email/password
    @IBAction func onSignIn(_ sender: Any) {
        let email = emailText.text!
        let password  = passwordText.text!

        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error: Error?)-> Void in
            if let error = error {
                self.displayFailAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
            
    func displayFailAlert(withTitle title: String, message: String) {
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
