//
//  PhotoAlbumViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import Combine

class PhotoAlbumViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var amountOfPhotosLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var groupViewButton: UIButton!
    @IBAction func groupViewButtonTapped(_ sender: Any) {
        selectedViewType = 1
    }
    
    @IBOutlet weak var individualViewButton: UIButton!
    @IBAction func individualViewButtonTapped(_ sender: Any) {
        selectedViewType = 2
    }
    
    @IBOutlet weak var dividerImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private var selectedViewType: Int = 0 {
        didSet {
            let screenWidth = UIScreen.main.bounds.width
            let spaceBetweenCells: CGFloat = 4
            
            let customFlowLayout = UICollectionViewFlowLayout()
            customFlowLayout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            customFlowLayout.scrollDirection = .vertical
            
            switch selectedViewType {
            case 1:
                // GroupView FlowLayout.
                let cellSize = CGSize(width: (screenWidth - (spaceBetweenCells * 2)) / 3, height: (screenWidth - (spaceBetweenCells * 2)) / 3)
                customFlowLayout.itemSize = cellSize
                customFlowLayout.minimumLineSpacing = spaceBetweenCells
                customFlowLayout.minimumInteritemSpacing = spaceBetweenCells
                
                // Buttons.
                groupViewButton.backgroundColor = UIColor(named: "myGrey")
                groupViewButton.tintColor = UIColor(named: "myDarkGrey")
                individualViewButton.backgroundColor = UIColor.white
                individualViewButton.tintColor = UIColor(named: "myDarkGrey")
            case 2:
                // Individual FlowLayout.
                let cellSize = CGSize(width: screenWidth, height: screenWidth)
                customFlowLayout.itemSize = cellSize
                customFlowLayout.minimumLineSpacing = spaceBetweenCells
                customFlowLayout.minimumInteritemSpacing = spaceBetweenCells
                
                // Buttons.
                groupViewButton.backgroundColor = UIColor.white
                groupViewButton.tintColor = UIColor(named: "myDarkGrey")
                individualViewButton.backgroundColor = UIColor(named: "myGrey")
                individualViewButton.tintColor = UIColor(named: "myDarkGrey")
            default:
                print("Error: Unknown 'selectedViewType'.")
            }
            
            collectionView.collectionViewLayout = customFlowLayout
            
            // If there are photos, scroll to the top.
            if photos.count > 0 {
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            
        }
    }
    
    private var viewModel = PhotoAlbumViewModel(apiManager: APIManager())
    private var subscribedTo: [AnyCancellable] = []
    
    private var photos: [Photo] = [] {
        didSet {
            updateCollectionView()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriptions()
        
        initView()
        initCollectionView()
        initActivityIndicator()
        
        viewModel.fetchAlbumPhotos()
    }
    
    private func initView() {
        title = "Fotos"
        
        // Label.
        amountOfPhotosLabel.text = "-"
    }
    
    private func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        selectedViewType = 1
        
        // Register cells.
        let photoThumbnailCell = UINib(nibName: "PhotoThumbnailCollectionViewCell", bundle: nil)
        collectionView.register(photoThumbnailCell, forCellWithReuseIdentifier: "PhotoThumbnailCollectionViewCell")
    }
    
    private func initActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
        
        showActivityIndicator()
    }
    
    @objc private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivityIndicator()
            
            self?.collectionView.reloadData()
            
            guard let count = self?.photos.count else { return }
            self?.amountOfPhotosLabel.text = "\(count)"
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func subscriptions() {
        viewModel.photos.sink { error in
            print("Error : \(error)")
        } receiveValue: { [weak self] photos in
            self?.photos = photos
        }.store(in: &subscribedTo)

    }
    
}

// MARK: - UICollectionView Delegate

extension PhotoAlbumViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = PhotoAlbumDetailViewController()
        detailVC.photo = photos[indexPath.row]
        show(detailVC, sender: self)
    }
    
}

// MARK: - UICollectionView Data Source

extension PhotoAlbumViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoThumbnailCollectionViewCell", for: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.thumbnailURLString = photos[indexPath.item].thumbnailURL
        return cell
    }
    
}
