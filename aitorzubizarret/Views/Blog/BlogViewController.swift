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
    
    private var viewModel = BlogViewModel(apiManager: APIManager.shared)
    private var subscribedTo: [AnyCancellable] = []
    
    private var posts: [BlogPost] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriptions()
        
        initView()
        initTableView()
        
        viewModel.fetchBlogPosts()
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
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        
        tableView.separatorStyle = .none
        
        // Register cells.
        let blogPostCell = UINib(nibName: "BlogPostTableViewCell", bundle: nil)
        tableView.register(blogPostCell, forCellReuseIdentifier: "BlogPostTableViewCell")
    }
    
    private func subscriptions() {
        viewModel.blogPosts.sink { error in
            print("Error : \(error)")
        } receiveValue: { [weak self] posts in
            self?.posts = posts
        }.store(in: &subscribedTo)

    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self ] in
            self?.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableView Delegate

extension BlogViewController: UITableViewDelegate {}

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
