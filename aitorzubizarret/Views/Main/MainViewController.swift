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

        initTableView()
    }
    
    private func initTableView() {
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
        
        let blogHeaderCell = UINib(nibName: "BlogHeaderTableViewCell", bundle: nil)
        tableView.register(blogHeaderCell, forCellReuseIdentifier: "BlogHeaderTableViewCell")
    }
    
}

// MARK: - UITableView Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 70
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let aboutMeVC = AboutMeViewController()
            show(aboutMeVC, sender: nil)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeTableViewCell", for: indexPath) as! AboutMeTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlogHeaderTableViewCell", for: indexPath) as! BlogHeaderTableViewCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - Blog Header Cell Actions

extension MainViewController: BlogHeaderCellActions {
    
    func goToBlogVC() {
        let blogVC = BlogViewController()
        show(blogVC, sender: nil)
    }
    
}
