//
//  AboutMeTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/8/22.
//

import UIKit

class AboutMeTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cartoonImageView: UIImageView!
    
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
        
        colorView.layer.cornerRadius = 6
    }
    
}
