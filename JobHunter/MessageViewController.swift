//
//  MessageViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Parse
import AlamofireImage

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
    
}

class MessageViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {
    // inherits from class in cocoapod
    
    var selectedPost : PFObject!


    
    let user = PFUser.current() // add parse functionality
    //let chats = PFObject(className: "Chats")
    
    //current user is dependent on whose view
    let currentUser = Sender(senderId: "self", displayName: "Job Hunter")
    let otherUser = Sender(senderId: "other", displayName: "Recruiter 1")
    
    var messages = [MessageType]() // make this a parse var - later
    
    
    
    
    
    //store structs? or just strings of message content then iterate through
    //Test message: I'm interested in this company's internship experience. Will I work closely with a mentor?
    
    
    

    // to publish new message
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        //print(text)
        //add to parse : update messageId number based on messages.count
        
        let count = messages.count + 1 // update messageID everytime
        messages.append(Message(sender: currentUser,
                                messageId: "\(count)",
                                        sentDate: Date().addingTimeInterval(-86399),
                                        kind: .text(text)))
    
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        
        //save messages in chat
        let chats = PFObject(className: "Chats")
        
        chats["ChatId"] = "Recruiter 1" // change this to OtherSender then link it to recruiter's account
        chats["Message"] = text
        chats["Author"] = user
        
        
        chats.saveInBackground() { (success, error) in
            if success {
                print("saved")
            } else{
                print("error")
            }
        }
         
    }
    
    //Update profile images
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        print("called")
        //56, 10, 154 = our custom logo color
        let customPurple = UIColor(red: 56/255, green: 10/255, blue: 154/255, alpha: 1)
      
        //current user vs. recruiter set profilfe photos
        if(messages[indexPath.section].sender.senderId == "self"){
            //print(indexPath.section % 2)
            if (user?["profileImage"] != nil) {
                let imageFile = user?["profileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                avatarView.af.setImage(withURL: url)
            }
            else {
                avatarView.backgroundColor = .white
                avatarView.image = UIImage(systemName: "person.circle.fill")?.withTintColor(customPurple, renderingMode: .alwaysOriginal)
            }
        }
        else { // recruiter
            avatarView.backgroundColor = .white
            avatarView.image = UIImage(systemName: "person.circle.fill")?.withTintColor(customPurple, renderingMode: .alwaysOriginal)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //hard coded -> need to add func to send message in app
        
        messages.append(Message(sender: otherUser,
                                messageId: "1", sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello, I received your resume and would be happy to answer any of your questions about this company.")))
        messages.append(Message(sender: currentUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-86399),
                                kind: .text("Hello, Recruiter 1!")))
        
        
        let query = PFQuery(className: "Chats")
        query.findObjectsInBackground() { (chats, error) ->
            Void in
            if error == nil{
                //no error in fetch
                if let returnedChats = chats{
                    var count = self.messages.count + 1// starts with 2
                    for message in returnedChats {
                        if(message["Message"] != nil){
                            print(message["Message"] as! String)
                            print("This is in the Query.")
                            
                            //append messages based on content in chats
                            //need to hook it up to selected chat and author
                            if(message["ChatId"] as! String == "Recruiter 1") {
                                self.messages.append(Message(sender: self.currentUser,
                                                             messageId: "\(count)",
                                                             sentDate: Date().addingTimeInterval(-86398),
                                                             kind: .text(message["Message"] as! String)))
                                self.messagesCollectionView.reloadData()
                                
                                count += 1 // update count for messageId
                            }
                        }
                    }
                }
            }
            
        }
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        
    }
    
    
    

    
    
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
                
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
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




