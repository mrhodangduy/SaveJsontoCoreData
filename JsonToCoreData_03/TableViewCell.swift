//
//  TableViewCell.swift
//  JsonToCoreData_03
//
//  Created by QTS Coder on 7/19/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblid: UILabel!
    @IBOutlet weak var lblfullname: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblip: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
