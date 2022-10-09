//
//  PostSectionTagsTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 8/10/22.
//

import UIKit

class PostSectionTagsTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    // MARK: - Properties
    
    var customTags: [BlogTag] = [] {
        didSet {
            var tagsString = ""
            
            for customTag in customTags {
                tagsString += "\(customTag.tag)    "
            }
            
            tagsLabel.text = tagsString
            
        }
    }
    
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
        
        tagsLabel.text = ""
    }
    
}
