//
//  PostSectionDateTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 8/10/22.
//

import UIKit

class PostSectionDateTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    
    var customDateString: String = "" {
        didSet {
            dateLabel.text = customDateString
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
        
        dateLabel.text = ""
    }
    
}
