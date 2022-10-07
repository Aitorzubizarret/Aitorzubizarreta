//
//  AppDetailViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 2/10/22.
//

import UIKit
import StoreKit // To display the AppStore.

class AppDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    var app: App?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initTableView()
    }
    
    private func initView() {
        title = "App"
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
        let appTitleCell = UINib(nibName: "AppTitleTableViewCell", bundle: nil)
        tableView.register(appTitleCell, forCellReuseIdentifier: "AppTitleTableViewCell")
        
        let appDescriptionCell = UINib(nibName: "AppDescriptionTableViewCell", bundle: nil)
        tableView.register(appDescriptionCell, forCellReuseIdentifier: "AppDescriptionTableViewCell")
        
        let appGoToAppStoreCell = UINib(nibName: "AppGoToAppStoreTableViewCell", bundle: nil)
        tableView.register(appGoToAppStoreCell, forCellReuseIdentifier: "AppGoToAppStoreTableViewCell")
    }
    
}

// MARK: - UITableView Delegate

extension AppDetailViewController: UITableViewDelegate {}

// MARK: - UITableView Data Source

extension AppDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppTitleTableViewCell", for: indexPath) as! AppTitleTableViewCell
            if let app = app {
                cell.appTitle = app.title
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDescriptionTableViewCell", for: indexPath) as! AppDescriptionTableViewCell
            if let app = app {
                cell.appDescription = app.description
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppGoToAppStoreTableViewCell", for: indexPath) as! AppGoToAppStoreTableViewCell
            cell.delegate = self
            if let app = app {
                cell.appStoreProductId = app.appStoreProductId
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - App GoToAppStore Actions

extension AppDetailViewController: AppGoToAppStoreActions {
    
    func goToAppStore(appProductId: String) {
        let appStoreVC = SKStoreProductViewController()
        appStoreVC.delegate = self
        
        let params = [SKStoreProductParameterITunesItemIdentifier: appProductId]
        appStoreVC.loadProduct(withParameters: params) { [weak self] _, error in
            if let _ = error {
                if let appWebURL: URL = URL(string: App.createWebAddress(appStoreProductId: appProductId)) {
                    UIApplication.shared.open(appWebURL)
                }
            } else {
                self?.present(appStoreVC, animated: true)
            }
        }
    }
    
}

extension AppDetailViewController: SKStoreProductViewControllerDelegate {
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true)
    }
    
}
