//
//  BlogPostTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import UIKit

class BlogPostTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postFirstDescriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var post: BlogPost? {
        didSet {
            guard let post = post,
                  let firstDescription = post.descriptions.first else { return }
            
            postDateLabel.text = post.getFormattedDate()
            postTitleLabel.text = post.title
            postFirstDescriptionLabel.text = firstDescription.description
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
}
