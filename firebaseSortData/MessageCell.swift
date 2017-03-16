//
//  MessageCell.swift
//  firebaseSortData
//
//  Created by Carlos Doki on 16/03/17.
//  Copyright © 2017 Carlos Doki. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var msgTextLabel: UILabel!
    
    var msg: Message!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(msg: Message) {
        self.msg = msg
        self.msgTextLabel.text = msg.msgText
    }

}
