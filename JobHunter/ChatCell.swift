//
//  ChatCell.swift
//  JobHunter
//
//  Created by Mary Hanson on 10/24/22.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var NavArrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
