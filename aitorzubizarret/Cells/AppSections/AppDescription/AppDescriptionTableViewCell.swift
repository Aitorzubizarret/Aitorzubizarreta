//
//  AppDescriptionTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 2/10/22.
//

import UIKit

class AppDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var appDesctiptionLabel: UILabel!
    
    // MARK: - Properties
    
    var appDescription: String = "" {
        didSet {
            appDesctiptionLabel.text = appDescription
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
