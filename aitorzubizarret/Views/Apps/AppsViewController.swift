//
//  AppsViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 29/9/22.
//

import UIKit

class AppsViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    var apps: [App] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initTableView()
    }
    
    private func initView() {
        title = "Apps útiles"
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        
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
        let appCell = UINib(nibName: "AppTableViewCell", bundle: nil)
        tableView.register(appCell, forCellReuseIdentifier: "AppTableViewCell")
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableView Delegate

extension AppsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDetailVC = AppDetailViewController()
        appDetailVC.app = apps[indexPath.row]
        show(appDetailVC, sender: nil)
    }
    
}

// MARK: - UITableView Data Source

extension AppsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppTableViewCell", for: indexPath) as! AppTableViewCell
        cell.app = apps[indexPath.row]
        return cell
    }
    
}
