//
//  BlogViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import UIKit
import Combine

class BlogViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    var posts: [BlogPost] = [] {
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
        title = "Blog"
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
        let blogPostCell = UINib(nibName: "BlogPostTableViewCell", bundle: nil)
        tableView.register(blogPostCell, forCellReuseIdentifier: "BlogPostTableViewCell")
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self ] in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableView Delegate

extension BlogViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blogDetailVC = BlogDetailViewController()
        show(blogDetailVC, sender: nil)
    }
    
}

// MARK: - UITableView Data Source

extension BlogViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogPostTableViewCell", for: indexPath) as! BlogPostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
}
