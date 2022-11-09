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
    
    
    @IBOutlet var cardStack: SwipeCardStack!
    
    // Model to hold data that we will extract from the JSON response
      struct JobCard: Codable {
          var companyName: String
          var jobTitle: String
          var jobDescription: String
          var remote: Bool
          var location: String
          var picture: String
      }
    
        
    struct Person: Codable{
            var firstName: String
            var lastName: String
        }
          
    func loadTextView1(textFill: String )-> UITextView {
        let textView = UITextView(frame: CGRect(x: 15, y: 29, width: 290, height: 288))
        textView.text = textFill
        textView.textColor = .white
        textView.backgroundColor = UIColor(red: 51/255, green: 13/255, blue: 148/255, alpha: 1)
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.isEditable = false

        return textView
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        print(jobs.count)
        print(people.count)
        let job = jobs[index]
    
        
        let card = SwipeCard()
        card.layer.cornerRadius = 10

        card.swipeDirections = [.left, .right]
        card.content = JobCardHeaderView(frame: CGRect.zero, jobTitle: job.jobTitle, jobDesc: job.jobDescription, image: UIImage(named: job.picture) ?? UIImage(named:"1.jpeg")!)
        
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.clipsToBounds = true
        card.footer = loadTextView1(textFill: job.companyName)
        card.footerHeight = 50
        card.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height - 100 ).isActive = true
        card.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 20).isActive = true
        card.content?.bottomAnchor.constraint(equalTo: card.footer!.topAnchor)
        
        let leftOverlay = UIView()
        leftOverlay.backgroundColor = UIColor.red.withAlphaComponent(0.5)
         
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = UIColor.green.withAlphaComponent(0.5)
         
        card.setOverlays([.left: leftOverlay, .right: rightOverlay])

        return card
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return jobs.count
    }
    
        
    var jobs = [JobCard]()
    var people = [Person]()
    
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
                var i = 1
                
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
                        location: location as! String,
                        picture: "\(i).jpeg")
                    
                    i+=1
                    self.jobs.append(temp)
                }
                
                // adding cardStack to view after API request is complete and data is stored
                self.cardStack.dataSource = self
                self.cardStack.delegate = self
                self.cardStack.clipsToBounds = true
                self.cardStack.frame = self.view.safeAreaLayoutGuide.layoutFrame
                self.cardStack.center = self.view.center
                self.view.addSubview(self.cardStack)
                
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
}
