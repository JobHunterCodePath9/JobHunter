//
//  SigninViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/19/22.
//

import UIKit

class SigninViewController: UIViewController {
    //MISSING: forgot password button - don't know what functionality that would be

    //created weak variables for the text fields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //created the action for the sign up button that goes straight to the registration screen
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
    ////created the action for the login button that goes straight to the main **MUST ADD FUNCTIONALITY**
    @IBAction func logInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
