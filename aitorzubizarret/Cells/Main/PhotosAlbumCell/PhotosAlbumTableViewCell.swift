//
//  PhotosAlbumTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/8/22.
//

import UIKit

class PhotosAlbumTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var leftTopBottomImageView: UIImageView!
    @IBOutlet weak var rightTopImageView: UIImageView!
    @IBOutlet weak var rightBottomImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
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
        
        // ImageViews.
        leftTopBottomImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        leftTopBottomImageView.layer.cornerRadius = 6
        
        rightTopImageView.layer.maskedCorners = [.layerMaxXMinYCorner]
        rightTopImageView.layer.cornerRadius = 6
        
        rightBottomImageView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        rightBottomImageView.layer.cornerRadius = 6
        
        rightBottomImageView.alpha = 0.3
    }
    
}
