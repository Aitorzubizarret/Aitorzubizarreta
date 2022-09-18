//
//  BlogHeaderTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 12/9/22.
//

import UIKit

protocol BlogHeaderCellActions {
    func goToBlogVC()
}

class BlogHeaderTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var allBlogPostsButton: UIButton!
    @IBAction func allBlogPostsButtonTapped(_ sender: Any) {
        goToBlogVC()
    }
    
    // MARK: - Properties
    
    var delegate: BlogHeaderCellActions?
    
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
    
    private func goToBlogVC() {
        guard let delegate = delegate else { return }
        
        delegate.goToBlogVC()
    }
    
}
