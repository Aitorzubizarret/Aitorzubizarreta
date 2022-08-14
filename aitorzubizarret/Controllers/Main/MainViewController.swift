//
//  MainViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 10/8/22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Constraints.
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.separatorStyle = .none
        
        // Register cells.
        let aboutMeCell: UINib = UINib(nibName: "AboutMeTableViewCell", bundle: nil)
        tableView.register(aboutMeCell, forCellReuseIdentifier: "AboutMeTableViewCell")
        
        let cvCell: UINib = UINib(nibName: "CVTableViewCell", bundle: nil)
        tableView.register(cvCell, forCellReuseIdentifier: "CVTableViewCell")
        
        let contactMeCell: UINib = UINib(nibName: "ContactMeTableViewCell", bundle: nil)
        tableView.register(contactMeCell, forCellReuseIdentifier: "ContactMeTableViewCell")
        
        let photosAlbum: UINib = UINib(nibName: "PhotosAlbumTableViewCell", bundle: nil)
        tableView.register(photosAlbum, forCellReuseIdentifier: "PhotosAlbumTableViewCell")
    }
    
}

// MARK: - UITableView Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 100
        case 1:
            return 80
        case 2:
            return 80
        case 3:
            return 170
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let aboutMeVC = AboutMeViewController()
            show(aboutMeVC, sender: nil)
        case 1:
            let cvVC = CVViewController()
            show(cvVC, sender: nil)
        case 2:
            let contactMeVC = ContactMeViewController()
            show(contactMeVC, sender: nil)
        case 3:
            let photoAlbumVC = PhotoAlbumViewController()
            show(photoAlbumVC, sender: nil)
        default:
            print("")
        }
    }
    
}

// MARK: - UITableView Data Source

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeTableViewCell", for: indexPath) as! AboutMeTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CVTableViewCell", for: indexPath) as! CVTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactMeTableViewCell", for: indexPath) as! ContactMeTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosAlbumTableViewCell", for: indexPath) as! PhotosAlbumTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
