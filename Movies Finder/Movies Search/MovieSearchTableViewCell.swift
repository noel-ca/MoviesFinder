//
//  MovieSearchTableViewCell.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView! {
        didSet {
            poster.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
            containerView.layer.shadowOpacity = 0.8
            containerView.layer.shadowRadius = 4
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
