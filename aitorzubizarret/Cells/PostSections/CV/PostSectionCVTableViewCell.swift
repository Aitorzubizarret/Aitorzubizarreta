//
//  PostSectionCVTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 12/10/22.
//

import UIKit

protocol PostSectionCVCellActions {
    func goToCVDetailVC()
}

class PostSectionCVTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    // MARK: - Properties
    
    var delegate: PostSectionCVCellActions?
    
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
        self.selectionStyle = .none
        
        mainView.backgroundColor = UIColor(named: "myWhite")
        
        mainView.layer.cornerRadius = 6
        
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(named: "myLightGrey")!.cgColor
        
        // Tap Gesture Recognizer.
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(goToCVDetailVCButtonTapped))
        mainView.addGestureRecognizer(tapGR)
    }
    
    @objc private func goToCVDetailVCButtonTapped() {
        guard let delegate = delegate else { return }
        
        delegate.goToCVDetailVC()
    }
    
}
