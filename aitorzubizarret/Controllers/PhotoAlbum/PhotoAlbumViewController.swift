//
//  PhotoAlbumViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit

class PhotoAlbumViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var displayOptionsSegmentControl: UISegmentedControl!
    
    @IBAction func displayOptionsSegmentControlChanged(_ sender: Any) {
        if displayOptionsSegmentControl.selectedSegmentIndex == 0 {
            changeCollectionViewLayout(individual: false)
        } else {
            changeCollectionViewLayout(individual: true)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    let photoThumbnails: [String] = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9", "photo10"]
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
    }


    private func setupView() {
        displayOptionsSegmentControl.backgroundColor = UIColor.white
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        changeCollectionViewLayout(individual: false)
        
        // Register cells.
        let photoThumbnailCell = UINib(nibName: "PhotoThumbnailCollectionViewCell", bundle: nil)
        collectionView.register(photoThumbnailCell, forCellWithReuseIdentifier: "PhotoThumbnailCollectionViewCell")
    }
    
    private func changeCollectionViewLayout(individual: Bool) {
        let screenWidth = UIScreen.main.bounds.width
        let spaceBetweenCells: CGFloat = 4
        
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        customFlowLayout.scrollDirection = .vertical
        
        if individual {
            let cellSize = CGSize(width: screenWidth, height: screenWidth)
            customFlowLayout.itemSize = cellSize
            customFlowLayout.minimumLineSpacing = spaceBetweenCells
            customFlowLayout.minimumInteritemSpacing = spaceBetweenCells
        } else {
            let cellSize = CGSize(width: (screenWidth - (spaceBetweenCells * 2)) / 3, height: (screenWidth - (spaceBetweenCells * 2)) / 3)
            customFlowLayout.itemSize = cellSize
            customFlowLayout.minimumLineSpacing = spaceBetweenCells
            customFlowLayout.minimumInteritemSpacing = spaceBetweenCells
        }
        
        collectionView.collectionViewLayout = customFlowLayout
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
        return photoThumbnails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoThumbnailCollectionViewCell", for: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.thumbnailImageName = photoThumbnails[indexPath.item]
        return cell
    }
    
}
