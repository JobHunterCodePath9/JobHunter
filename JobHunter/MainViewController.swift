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

        let url = URL(string: "https://data.usajobs.gov/api/search?Keyword=Software")
        let apiKey = "hG4xxpCGhesumgUZwSSsqPVzvxge8N7gDLkmHbNtgro="
        let userAgent = "prestonbarney123@gmail.com"

        let headers: HTTPHeaders = ["Host": "data.usajobs.gov", "User-Agent": "prestonbarney123@gmail.com" , "Authorization-Key": apiKey]

        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData


        let request = AF.request("https://arbeitnow.com/api/job-board-api")
            
        request.responseJSON{ (data) in
            print(data)
            }
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


