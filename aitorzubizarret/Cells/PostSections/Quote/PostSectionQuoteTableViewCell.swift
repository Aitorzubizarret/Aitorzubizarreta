//
//  PostSectionQuoteTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import UIKit

class PostSectionQuoteTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var quoteOpeningImageView: UIImageView!
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var quoteClosingImageView: UIImageView!
    
    // MARK: - Properties
    
    var customQuote: String = "" {
        didSet {
            quoteTextLabel.text = customQuote
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
        quoteTextLabel.text = ""
    }
    
}
