//
//  PostCell.swift
//  Assessment
//
//  Created by apple on 26/04/24.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func displayData(data: PostModel) {
        lblID.text = data.id.codingKey.stringValue
        lblTitle.text = data.title
    }
}
