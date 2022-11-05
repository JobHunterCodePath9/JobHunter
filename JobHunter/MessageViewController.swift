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


    
    let user = PFUser.current() // add parse functionality
    //let chats = PFObject(className: "Chats")
    
    let currentUser = Sender(senderId: "self", displayName: "Job Hunter")
    let otherUser = Sender(senderId: "other", displayName: "Recruiter 1")
    
    var messages = [MessageType]() // make this a parse var - later
    
    let messageVars = PFObject(className: "Messages")
    
    

    // to publish new message
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print(text)
        //add to parse : update messageId number based on messages.count
        
        let count = messages.count + 1 // update messageID everytime
        messages.append(Message(sender: currentUser,
                                messageId: "\(count)",
                                        sentDate: Date().addingTimeInterval(-86399),
                                        kind: .text(text)))
    
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
         
    }
    
    //Update profile images
    /*func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        print("called")
        //Need to fix this.
        if(message.messageId == "currentUser" ){
            
            if (user?["profileImage"] != nil) {
                let imageFile = user?["profileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
            
                avatarView.af.setImage(withURL: url)
            }
        }
    }*/
    
    
    
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
        
        
        // struct, prob can't do this
        
        //test how many
        print(messages.count)
        
        
        
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        removeMessageAvatars()
        
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
    
    //removes avatars -> or fix adding profile image
    private func removeMessageAvatars() {
      guard
        let layout = messagesCollectionView.collectionViewLayout
          as? MessagesCollectionViewFlowLayout
      else {
        return
      }
      layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
      layout.textMessageSizeCalculator.incomingAvatarSize = .zero
      layout.setMessageIncomingAvatarSize(.zero)
      layout.setMessageOutgoingAvatarSize(.zero)
      let incomingLabelAlignment = LabelAlignment(
        textAlignment: .left,
        textInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
      layout.setMessageIncomingMessageTopLabelAlignment(incomingLabelAlignment)
      let outgoingLabelAlignment = LabelAlignment(
        textAlignment: .right,
        textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15))
      layout.setMessageOutgoingMessageTopLabelAlignment(outgoingLabelAlignment)
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


