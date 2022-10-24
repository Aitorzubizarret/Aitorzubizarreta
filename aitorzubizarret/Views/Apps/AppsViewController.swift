//
//  AppsViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 29/9/22.
//

import UIKit
import Combine

class AppsViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    private var viewModel: AppsViewModel
    private var subscribedTo: [AnyCancellable] = []
    
    var apps: [App] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Methods
    
    init(viewModel: AppsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriptions()
        
        initView()
        initTableView()
        
        viewModel.fetchApps()
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
    
    private func subscriptions() {
        viewModel.apps.sink { receiveCompletion in
            switch receiveCompletion {
            case .finished:
                print("Finished Apps")
            case .failure(let error):
                print("Error : \(error)")
            }
        } receiveValue: { [weak self] apps in
            self?.apps = apps
        }.store(in: &subscribedTo)

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
