//
//  AppGoToAppStoreTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 2/10/22.
//

import UIKit

protocol AppGoToAppStoreActions {
    func goToAppStore(appProductId: String)
}

class AppGoToAppStoreTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var appGoToAppStoreButton: UIButton!
    @IBAction func appGoToAppStoreButtonTapped(_ sender: Any) {
        openAppStore()
    }
    
    // MARK: - Properties
    
    var delegate: AppGoToAppStoreActions?
    var appStoreProductId: String?
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func openAppStore() {
        guard let delegate = delegate,
              let appStoreProductId = appStoreProductId else { return }
        
        delegate.goToAppStore(appProductId: appStoreProductId)
    }
    
}
