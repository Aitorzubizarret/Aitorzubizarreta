//
//  AppsHeaderTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import UIKit

protocol AppsHeaderCellActions {
    func goToAppsListVC()
}

class AppsHeaderTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var allAppsButton: UIButton!
    @IBAction func allAppsButtonTapped(_ sender: Any) {
        goToAppsListVC()
    }
    
    // MARK: - Properties
    
    var delegate: AppsHeaderCellActions?
    
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
        
        // Attributed Button Title.
        let buttonText: String = "TODAS"
        let font = UIFont(name: "Helvetica Neue Bold", size: 14.0)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedButtonText = NSAttributedString(string: buttonText, attributes: attributes as [NSAttributedString.Key : Any])
        
        allAppsButton.setAttributedTitle(attributedButtonText, for: .normal)
    }
    
    private func goToAppsListVC() {
        guard let delegate = delegate else { return }
        
        delegate.goToAppsListVC()
    }
    
}
