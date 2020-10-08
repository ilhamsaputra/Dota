//
//  RoleTableViewCell.swift
//  Dota
//
//  Created by ilhamsaputra on 09/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import UIKit

class RoleTableViewCell: UITableViewCell {

    @IBOutlet weak var roleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
