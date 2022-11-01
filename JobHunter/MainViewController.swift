//
//  MainViewController.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let url = URL(string: "https://data.usajobs.gov/api/search?Keyword=Software")
        //        let apiKey = "hG4xxpCGhesumgUZwSSsqPVzvxge8N7gDLkmHbNtgro="
        //        let userAgent = "prestonbarney123@gmail.com"
        //
        //        let headers: HTTPHeaders = ["Host": "data.usajobs.gov", "User-Agent": "prestonbarney123@gmail.com" , "Authorization-Key": apiKey]
        
        
        // Model to hold data that we will extract from the JSON response
        struct Job: Codable {
            var companyName: String
            var jobTitle: String
            var jobDescription: String
            var remote: Bool
            var location: String
        }
        
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        // Array to hold extracted jobs
        var jobs = [Job]()
        
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
                    let temp = Job(
                        companyName: companyName as! String,
                        jobTitle: jobTitle as! String,
                        jobDescription: jobDescription as! String,
                        remote: remote as! Bool,
                        location: location as! String
                    )
                    
                    jobs.append(temp)
                }
                
                // testing output
                for job in jobs {
                    print(job)
                }
                
            case.failure(let error):
                print("error: \(error)")
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
}
