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
    
    var thumbnailURLString: String = "" {
        didSet {
            guard let safeURL = URL(string: thumbnailURLString) else { return }
            thumbnailImageView.download(from: safeURL)
        }
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initSetup()
    }
    
    private func initSetup() {
        thumbnailImageView.image = UIImage(named: "photo-placecholder")
    }
    
}
