//
//  PhotoThumbnailCollectionViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit

class PhotoThumbnailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // MARK: - Properties
    
    var thumbnailImageName: String = "" {
        didSet {
            if !thumbnailImageName.isEmpty {
                thumbnailImageView.image = UIImage(named: thumbnailImageName)
            }
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
