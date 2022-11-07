//
//  SignUpViewController.swift
//  JobHunter
//
//  Created by Sunny Yu on 10/23/22.
//

import UIKit
import Parse
import AlamofireImage
import MobileCoreServices
import UniformTypeIdentifiers


class SignUpViewController: UIViewController, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
    //it is deprecated but it works fine
    //you have to add files to your simulator to access them in the app
    //to add a resume pdf to your simulator, add the file in the simulator folder
    
    var pdfData: PFFileObject!
    
    func selectFiles() {
        let types = UTType.types(tag: "json",
                                 tagClass: UTTagClass.filenameExtension,
                                 conformingTo: nil)
        let documentPickerController = UIDocumentPickerViewController(
                forOpeningContentTypes: types)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        
        //save pdf in global var to add to parse
        var myData = NSData(contentsOf: myURL)!
        self.pdfData = PFFileObject(name: "Resume", data: myData as Data) // this works but u can't access the pdf in parse -> saved as a bin file
        
        print("import result : \(myURL)")
    }
    
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    }
    

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onUploadResume(_ sender: Any) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onRegister(_ sender: Any) {

        var username = self.nameText.text
        var password = self.passwordText.text
        var email = self.emailText.text
       
        if (email!.isEmpty || username!.isEmpty || password!.isEmpty) {
            self.displayFailAlert(withTitle: "Error", message: "All fields are required")
        }
        
        let user = PFUser()
                
        user.email = email
        user.password = password
        user.username = username
        user["Resume"] = pdfData // might be an error
        
        
        user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                self.displayFailAlert(withTitle: "Error", message: error.localizedDescription)
            } else {
                self.displaySuccessAlert(withTitle: "Success", message: "Account has been successfully created")
            }
        }
        
        //add resume to cre
        //let currentUser = PFUser.current()!
        
        
        
        
        // neef fix: should display msg then perfom segue, login should check if user exist rather than auto sign in 
        //self.performSegue(withIdentifier: "signinSegue", sender: nil)
                
    }
    
    func displayFailAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
    }
    
    func displaySuccessAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
        })
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
