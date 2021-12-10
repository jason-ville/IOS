//
//  MailTableViewCell.swift
//  Imail
//
//  Created by Jason Ville on 01/12/2021.
//

import UIKit

class MailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(text1: String, text2 : String, text3 : String){
        self.textLabel1?.text = text1
        self.textLabel2?.text = text2
        self.textLabel3?.text = text3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
