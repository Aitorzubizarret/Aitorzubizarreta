//
//  PostSectionTitleTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import UIKit

class PostSectionTitleTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    var customTitle: String = "" {
        didSet {
            let attributedText = NSMutableAttributedString(string: customTitle)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.4
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            
            titleLabel.attributedText = attributedText
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
        titleLabel.text = ""
        titleLabel.attributedText = NSMutableAttributedString(string: "")
    }
    
}
