//
//  PostSectionDescriptionTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import UIKit

class PostSectionDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var customDescription: String = "" {
        didSet {
            let attributedText = NSMutableAttributedString(string: customDescription)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.4
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            descriptionLabel.attributedText = attributedText
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
        descriptionLabel.text = ""
        descriptionLabel.attributedText = NSMutableAttributedString(string: "")
    }
    
}
