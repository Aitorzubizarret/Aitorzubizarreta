//
//  PhotoAlbumViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit

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
    
    var selectedViewType: Int = 0 {
        didSet {
            let screenWidth = UIScreen.main.bounds.width
            let spaceBetweenCells: CGFloat = 4
            
            let customFlowLayout = UICollectionViewFlowLayout()
            customFlowLayout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
            customFlowLayout.scrollDirection = .vertical
            
            switch selectedViewType {
            case 1:
                // FlowLayout.
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
                // FlowLayout.
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
                print("")
            }
            
            collectionView.collectionViewLayout = customFlowLayout
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        
        DataManager.shared.getPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: Notification.Name("Photos"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Photos"), object: nil)
    }
    
    private func setupView() {}
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        selectedViewType = 1
        
        // Register cells.
        let photoThumbnailCell = UINib(nibName: "PhotoThumbnailCollectionViewCell", bundle: nil)
        collectionView.register(photoThumbnailCell, forCellWithReuseIdentifier: "PhotoThumbnailCollectionViewCell")
    }
    
    @objc private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
            self?.amountOfPhotosLabel.text = "\(DataManager.shared.photos.count)"
        }
    }
    
}

// MARK: - UICollectionView Delegate

extension PhotoAlbumViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Photo thumbnail selected at \(indexPath.item)")
    }
    
}

// MARK: - UICollectionView Data Source

extension PhotoAlbumViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoThumbnailCollectionViewCell", for: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.thumbnailURLString = DataManager.shared.photos[indexPath.item].thumbnailURL
        return cell
    }
    
}
