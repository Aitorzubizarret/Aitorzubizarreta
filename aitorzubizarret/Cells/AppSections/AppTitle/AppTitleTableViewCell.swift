//
//  AppTitleTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 2/10/22.
//

import UIKit

class AppTitleTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    // MARK: - Properties
    
    var appTitle: String = "" {
        didSet {
            appTitleLabel.text = appTitle
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
