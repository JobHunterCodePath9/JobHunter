//
//  MessageViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import MessageKit
import Parse

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

class MessageViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    // inherits from class in cocoapod
    
    let user = PFUser.current() // add parse functionality
    
    let currentUser = Sender(senderId: "self", displayName: "Job Hunter")
    let otherUser = Sender(senderId: "other", displayName: "Recruiter 1")
    
    var messages = [MessageType] () // make this a parse var - later
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //hard coded -> need to add func to send message in app
        messages.append(Message(sender: otherUser,
                                messageId: "1", sentDate: Date().addingTimeInterval(-1000),
                                kind: .text("Hello, I received your resume and would be happy to answer any of your questions about this company.")))
        messages.append(Message(sender: currentUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-700),
                                kind: .text("Hello, Recruiter 1!")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

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
