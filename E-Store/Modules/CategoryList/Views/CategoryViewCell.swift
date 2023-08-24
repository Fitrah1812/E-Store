//
//  CategoryViewCell.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 8
        thumbImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
