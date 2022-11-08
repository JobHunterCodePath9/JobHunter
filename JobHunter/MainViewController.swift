//
//  MainViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import Alamofire
import Shuffle_iOS

class MainViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate {
    
    private let cardStack = SwipeCardStack()
    
    // Model to hold data that we will extract from the JSON response
          struct JobCard: Codable {
              var companyName: String
              var jobTitle: String
              var jobDescription: String
              var remote: Bool
              var location: String
          }
          

    
    func loadTextView1(textFill: String )-> UITextView {
        let textView1 = UITextView(frame: CGRect(x: 15, y: 29, width: 290, height: 288))
        textView1.text = textFill
       
        
        textView1.backgroundColor = .white

        textView1.isEditable = false

        return textView1
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let job = jobs[index]
        
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
        card.footerHeight = 80
        card.content = loadTextView1(textFill: job.jobDescription)
        card.footer = loadTextView1(textFill: job.jobTitle)
        card.clipsToBounds = true

        
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = .red
         
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .green
         
        card.setOverlays([.left: leftOverlay, .right: rightOverlay])
        
        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return jobs.count
    }
    
        
    var jobs = [JobCard]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Model to hold data that we will extract from the JSON response
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        // Array to hold extracted jobs
        AF.request("https://arbeitnow.com/api/job-board-api").responseJSON { response in
            switch response.result {
                
            // parsing JSON
            case .success(let JSON):
                let response = JSON as! NSDictionary
                let data = response.object(forKey: "data") as! NSArray
                
                for obj in data {
                    let listing = obj as! NSDictionary
                    let companyName = listing.object(forKey: "company_name")
                    let jobTitle = listing.object(forKey: "title")
                    let jobDescription = listing.object(forKey: "description")
                    let remote = listing.object(forKey: "remote")
                    let location = listing.object(forKey: "location")
                    
                    // creating a job object to add to dictionary
                    let temp = JobCard(
                        companyName: companyName as! String,
                        jobTitle: jobTitle as! String,
                        jobDescription: jobDescription as! String,
                        remote: remote as! Bool,
                        location: location as! String
                    )
                    
                    self.jobs.append(temp)
                    
                }
                
                // testing output
                print(self.jobs.count)
                self.cardStack.dataSource = self
                self.cardStack.delegate = self
                self.cardStack.frame = CGRect(x: 0,
                                         y: 0,
                                              width: self.view.frame.width - 50,
                                              height: self.view.frame.height - 150)
                self.cardStack.center = self.view.center
                self.view.addSubview(self.cardStack)
                
            case.failure(let error):
                print("error: \(error)")
            }
            
        }
        
    }
}
