//
//  PostTableViewCell.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var LBLTitle: UILabel!
    @IBOutlet weak var LBLBody: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
