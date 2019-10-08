//
//  SearchCell.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/6/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var age: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
