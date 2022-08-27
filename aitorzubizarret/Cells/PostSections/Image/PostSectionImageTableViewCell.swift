//
//  PostSectionImageTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import UIKit

class PostSectionImageTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Properties
    
    var customPhotoURLString: String = "" {
        didSet {
            guard let customPhotoURL = URL(string: customPhotoURLString) else { return }
            
            photoImageView.download(from: customPhotoURL)
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
