//
//  PostSectionSubtitleTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import UIKit

class PostSectionSubtitleTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Properties
    
    var customSubtitle: String = "" {
        didSet {
            let attributedText = NSMutableAttributedString(string: customSubtitle)
            
            subtitleLabel.attributedText = attributedText
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
        subtitleLabel.text = ""
        subtitleLabel.attributedText = NSMutableAttributedString(string: "")
    }
    
}
