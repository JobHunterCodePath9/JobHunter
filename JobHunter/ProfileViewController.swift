//
//  ProfileViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import Parse
import AlamofireImage
import MobileCoreServices
import UniformTypeIdentifiers

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
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
        
        //save pdf to add to parse
        var myData = NSData(contentsOf: myURL)!
        var pdfData = PFFileObject(name: "Resume", data: myData as Data) // this works but u can't access the pdf in parse -> saved as a bin file
        
        let user = PFUser.current()!
        user["Resume"] = pdfData
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else{
                print("error")
            }
        }
        
        print("import result : \(myURL)")
    }
    
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    }
    
    
    @IBAction func reuploadResumeButton(_ sender: Any) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = loginViewController
        
    }
    
    var addedProfileImage = false
    
    @IBAction func addProfileImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage // comes in a dictionary
        
        let size = CGSize(width: 200, height: 200)
        let scaledImage = image.af.imageScaled(to: size)
        
        profileImage.image = scaledImage
        
        let user = PFUser.current()!
        
        let imageData = profileImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        user["profileImage"] = file
        
        user.saveInBackground { (success, error) in
            if success {
                print("saved")
                self.dismiss(animated: true, completion: nil)
            } else{
                print("error")
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sometimes this stuff just doesnt work
        let user = PFUser.current()
        
        //make profile image view circular
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        
        nameLabel.text = user?.username
        emailLabel.text = user?.email
        
        if (user?["profileImage"] != nil) {
            let imageFile = user?["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
        
            profileImage.af.setImage(withURL: url)
        }
        
        
        
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
