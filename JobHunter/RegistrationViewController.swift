//
//  RegistrationViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/19/22.
//

import UIKit

class RegistrationViewController: UIViewController {
    //MISSING: upload resume button - not sure what functionality that would be

   //created weak variables for name, password, and email text fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //created segue action for sign in button that goes straight to sign in page
    @IBAction func signInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    ////created the action for the register button that goes straight to the main **MUST ADD FUNCTIONALITY**
    @IBAction func registerButton(_ sender: Any) {
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
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
