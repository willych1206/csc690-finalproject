//
//  ProductCell.swift
//  Sneakersell
//
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var lblProduct: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
