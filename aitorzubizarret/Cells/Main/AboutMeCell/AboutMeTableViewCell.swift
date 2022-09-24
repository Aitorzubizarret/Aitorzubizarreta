//
//  AboutMeTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/8/22.
//

import UIKit

class AboutMeTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Properties
    
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
        self.selectionStyle = .none
        
        // Corner radius.
        let width = photoImageView.layer.bounds.width
        photoImageView.layer.cornerRadius = width / 2
        
        // Border.
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        
    }
    
}
