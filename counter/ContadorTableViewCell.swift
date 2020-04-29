//
//  ContadorTableViewCell.swift
//  counter
//
//  Created by Invitado on 4/29/20.
//  Copyright © 2020 Invitado. All rights reserved.
//

import UIKit

class ContadorTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cantidad: UILabel!

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnIncrementar: UIButton!
    @IBOutlet weak var btnDec: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
