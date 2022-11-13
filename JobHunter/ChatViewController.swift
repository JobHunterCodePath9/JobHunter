//
//  ChatViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.leftItemsSupplementBackButton = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //update view
        tableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        cell.companyNameLabel.text = "Recruiter 1"
        
        let query = PFQuery(className: "Chats")
        query.findObjectsInBackground() { (chats, error) ->
            Void in
            if error == nil{
                //no error in fetch
                if let returnedChats = chats {
                    if (returnedChats[returnedChats.count - 1]["Message"] != nil){
                        //set it to current message
                        cell.messageLabel.text = returnedChats[returnedChats.count - 1]["Message"] as? String
                    }
                }
            }
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //segue from table view cell to indivdual messaging
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("loading the details")
        
        //find selected cell
        let cell = sender as! UITableViewCell // sender tracks which cell calls
        let indexPath = tableView.indexPath(for: cell)! // tableview has func for finding cell ind
    
        
        //pass selected movie to details
    
        
        //get rid of highlighted selection
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
