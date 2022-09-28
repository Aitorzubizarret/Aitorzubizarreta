//
//  AppTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    // MARK: - UI elements
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    // MARK: - Properties
    
    var app: App? {
        didSet {
            guard let app = app else { return }
            
            appNameLabel.text = app.title
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initView() {
        selectionStyle = .none
    }
    
}
