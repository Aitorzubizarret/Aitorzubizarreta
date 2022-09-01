//
//  ContactMeTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/8/22.
//

import UIKit

class ContactMeTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupView() {
        self.selectionStyle = .none
        
        mainView.backgroundColor = UIColor.white
        
        mainView.layer.cornerRadius = 6
        
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(named: "myDarkBlue")!.cgColor
    }
    
}
