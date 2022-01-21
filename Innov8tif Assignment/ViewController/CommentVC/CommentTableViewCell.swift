//
//  CommentTableViewCell.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LBLName: UILabel!
    @IBOutlet weak var LBLEmail: UILabel!
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
