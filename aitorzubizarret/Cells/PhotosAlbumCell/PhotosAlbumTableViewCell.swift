//
//  PhotosAlbumTableViewCell.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/8/22.
//

import UIKit

class PhotosAlbumTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    let photo1Image = UIImage(named: "photo1")
    let photo2Image = UIImage(named: "photo2")
    let photo3Image = UIImage(named: "photo3")
    let photo4Image = UIImage(named: "photo4")
    let photo5Image = UIImage(named: "photo5")
    let photo6Image = UIImage(named: "photo6")
    let photo7Image = UIImage(named: "photo7")
    let photo8Image = UIImage(named: "photo8")
    let photo9Image = UIImage(named: "photo9")
    let photo10Image = UIImage(named: "photo10")
    
    var photo1ImageView = UIImageView()
    var photo2ImageView = UIImageView()
    var photo3ImageView = UIImageView()
    var photo4ImageView = UIImageView()
    var photo5ImageView = UIImageView()
    var photo6ImageView = UIImageView()
    var photo7ImageView = UIImageView()
    var photo8ImageView = UIImageView()
    var photo9ImageView = UIImageView()
    var photo10ImageView = UIImageView()
    
    var photoViewWidth: CGFloat = 0
    var photoViewHeight: CGFloat = 0
    var photoHeight: CGFloat = 0
    
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
        
        // Main View.
        mainView.backgroundColor = UIColor.white
        
        mainView.layer.cornerRadius = 6
        
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(named: "myDarkBlue")!.cgColor
        
        mainView.layer.masksToBounds = true
        
        // Photo View.
        photoViewWidth = mainView.layer.bounds.width
        photoViewHeight = mainView.layer.bounds.height
        
        photoHeight = photoViewHeight / 2
        
        // Image View.
        photo1ImageView.image = photo1Image
        photo1ImageView.alpha = 0.7
        photo1ImageView.frame = CGRect(x: 0, y: 0, width: photoHeight, height: photoHeight)
        
        photo2ImageView.image = photo2Image
        photo2ImageView.alpha = 0.7
        photo2ImageView.frame = CGRect(x: (photoHeight*1), y: 0, width: photoHeight, height: photoHeight)
        
        photo3ImageView.image = photo3Image
        photo3ImageView.alpha = 0.7
        photo3ImageView.frame = CGRect(x: (photoHeight*2), y: 0, width: photoHeight, height: photoHeight)
        
        photo4ImageView.image = photo4Image
        photo4ImageView.alpha = 0.7
        photo4ImageView.frame = CGRect(x: (photoHeight*3), y: 0, width: photoHeight, height: photoHeight)
        
        photo5ImageView.image = photo5Image
        photo5ImageView.alpha = 0.7
        photo5ImageView.frame = CGRect(x: (photoHeight*4), y: 0, width: photoHeight, height: photoHeight)
        
        photo6ImageView.image = photo6Image
        photo6ImageView.alpha = 0.7
        photo6ImageView.frame = CGRect(x: 0, y: (photoHeight), width: photoHeight, height: photoHeight)
        
        photo7ImageView.image = photo7Image
        photo7ImageView.alpha = 0.7
        photo7ImageView.frame = CGRect(x: (photoHeight*1), y: photoHeight, width: photoHeight, height: photoHeight)
        
        photo8ImageView.image = photo8Image
        photo8ImageView.alpha = 0.7
        photo8ImageView.frame = CGRect(x: (photoHeight*2), y: photoHeight, width: photoHeight, height: photoHeight)
        
        photo9ImageView.image = photo9Image
        photo9ImageView.alpha = 0.7
        photo9ImageView.frame = CGRect(x: (photoHeight*3), y: photoHeight, width: photoHeight, height: photoHeight)
        
        photo10ImageView.image = photo10Image
        photo10ImageView.alpha = 0.7
        photo10ImageView.frame = CGRect(x: (photoHeight*4), y: photoHeight, width: photoHeight, height: photoHeight)
        
        mainView.addSubview(photo1ImageView)
        mainView.addSubview(photo2ImageView)
        mainView.addSubview(photo3ImageView)
        mainView.addSubview(photo4ImageView)
        mainView.addSubview(photo5ImageView)
        mainView.addSubview(photo6ImageView)
        mainView.addSubview(photo7ImageView)
        mainView.addSubview(photo8ImageView)
        mainView.addSubview(photo9ImageView)
        mainView.addSubview(photo10ImageView)
    }
    
}
