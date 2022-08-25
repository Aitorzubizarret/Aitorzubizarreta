//
//  AboutMeViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        DataManager.shared.getAboutMe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: Notification.Name("AboutMe"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AboutMe"), object: nil)
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Constraints.
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.separatorStyle = .none
        
        // Register cells.
        let postSectionImageCell = UINib(nibName: "PostSectionImageTableViewCell", bundle: nil)
        tableView.register(postSectionImageCell, forCellReuseIdentifier: "PostSectionImageTableViewCell")
        
        let postSectionTitleCell = UINib(nibName: "PostSectionTitleTableViewCell", bundle: nil)
        tableView.register(postSectionTitleCell, forCellReuseIdentifier: "PostSectionTitleTableViewCell")
        
        let postSectionSubtitleCell = UINib(nibName: "PostSectionSubtitleTableViewCell", bundle: nil)
        tableView.register(postSectionSubtitleCell, forCellReuseIdentifier: "PostSectionSubtitleTableViewCell")
        
        let postSectionQuoteCell = UINib(nibName: "PostSectionQuoteTableViewCell", bundle: nil)
        tableView.register(postSectionQuoteCell, forCellReuseIdentifier: "PostSectionQuoteTableViewCell")
        
        let postSectionDescriptionCell = UINib(nibName: "PostSectionDescriptionTableViewCell", bundle: nil)
        tableView.register(postSectionDescriptionCell, forCellReuseIdentifier: "PostSectionDescriptionTableViewCell")
    }
    
    @objc private func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableView Delegate

extension AboutMeViewController: UITableViewDelegate {}

// MARK: - UITableView Data Source

extension AboutMeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.aboutMePostSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataManager.shared.aboutMePostSections[indexPath.row].getCustomTableViewCell(tableView: tableView, indexPath: indexPath)
        return cell
    }
    
}
