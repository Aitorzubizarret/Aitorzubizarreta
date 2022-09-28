//
//  MainViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 10/8/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    
    private var viewModel = MainViewModel(apiManager: APIManager.shared)
    private var subscribedTo: [AnyCancellable] = []
    
    private var posts: [BlogPost] = [] {
        didSet {
            if posts.count > 5 {
                postsForHomeSection = Array(posts.prefix(5))
            } else {
                postsForHomeSection = posts
            }
        }
    }
    private var postsForHomeSection: [BlogPost] = [] {
        didSet {
            updateTableView()
        }
    }
    private var apps: [App] = [] {
        didSet {
            if apps.count > 3 {
                appsForHomeSection = Array(apps.prefix(3))
            } else {
                appsForHomeSection = apps
            }
        }
    }
    private var appsForHomeSection: [App] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriptions()
        
        initTableView()
        
        viewModel.fetchBlogPosts()
        viewModel.fetchApps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
        
        let blogPostCell = UINib(nibName: "BlogPostTableViewCell", bundle: nil)
        tableView.register(blogPostCell, forCellReuseIdentifier: "BlogPostTableViewCell")
        
        let appsHeaderCell = UINib(nibName: "AppsHeaderTableViewCell", bundle: nil)
        tableView.register(appsHeaderCell, forCellReuseIdentifier: "AppsHeaderTableViewCell")
        
        let appCell = UINib(nibName: "AppTableViewCell", bundle: nil)
        tableView.register(appCell, forCellReuseIdentifier: "AppTableViewCell")
        
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self ] in
            self?.tableView.reloadData()
        }
    }
    
    private func subscriptions() {
        viewModel.blogPosts.sink { error in
            print("Error : \(error)")
        } receiveValue: { [weak self] posts in
            self?.posts = posts
        }.store(in: &subscribedTo)
        
        viewModel.apps.sink { error in
            print("Error : \(error)")
        } receiveValue: { [weak self] apps in
            self?.apps = apps
        }.store(in: &subscribedTo)
    }
    
}

// MARK: - UITableView Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let aboutMeVC = AboutMeViewController()
            show(aboutMeVC, sender: nil)
        case 1:
            if indexPath.row != 0 {
                let blogDetailVC = BlogDetailViewController()
                show(blogDetailVC, sender: nil)
            }
        default:
            print("")
        }
    }
    
}

// MARK: - UITableView Data Source

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // "About Me" section.
        case 1: return 1 + postsForHomeSection.count // "Blog" section.
        case 2: return 1 + appsForHomeSection.count // "Apps" section.
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // "About Me" section.
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutMeTableViewCell", for: indexPath) as! AboutMeTableViewCell
            return cell
        case 1: // "Blog" section.
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlogHeaderTableViewCell", for: indexPath) as! BlogHeaderTableViewCell
                cell.delegate = self
                cell.numberOfPosts = posts.count
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BlogPostTableViewCell", for: indexPath) as! BlogPostTableViewCell
                cell.post = posts[indexPath.row - 1]
                return cell
            }
        case 2: // "Apps" section
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppsHeaderTableViewCell", for: indexPath) as! AppsHeaderTableViewCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppTableViewCell", for: indexPath) as! AppTableViewCell
                cell.app = appsForHomeSection[indexPath.row - 1]
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - Blog Header Cell Actions

extension MainViewController: BlogHeaderCellActions {
    
    func goToBlogVC() {
        let blogVC = BlogViewController()
        blogVC.posts = posts
        show(blogVC, sender: nil)
    }
    
}
