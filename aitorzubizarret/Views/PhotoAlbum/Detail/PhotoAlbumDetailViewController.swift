//
//  PhotoAlbumDetailViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 28/8/22.
//

import UIKit

class PhotoAlbumDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var imageCustomImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    var photo: Photo? = nil
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        displayData()
    }
    
    private func initView() {
        imageCustomImageView.enableZoomAndPan()
    }
    
    private func displayData() {
        guard let safePhoto = photo,
              let photoURL = URL(string: safePhoto.originalURL) else { return }
        
        imageCustomImageView.download(from: photoURL)
        titleLabel.text = safePhoto.title
        creationDateLabel.text = safePhoto.creationDate
        locationNameLabel.text = safePhoto.location
        descriptionLabel.text = safePhoto.description
    }
    
}
