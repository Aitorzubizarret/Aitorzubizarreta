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
    
    private var viewModel: MainViewModel
    private var subscribedTo: [AnyCancellable] = []
    
    private var posts: [BlogPost] = [] {
        didSet {
            updateTableView()
        }
    }
    private var postCount: Int = 0
    private var apps: [App] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Methods
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func subscriptions() {
        viewModel.blogPosts.sink { receiveCompletion in
            switch receiveCompletion {
            case .finished:
                print("Finished BlogPosts")
            case .failure(let error):
                print("Error : \(error)")
            }
        } receiveValue: { [weak self] posts in
            self?.posts = posts
        }.store(in: &subscribedTo)
        
        viewModel.blogPostsCount.sink { receiveCompletion in
            switch receiveCompletion {
            case .finished:
                print("Finished BlogPostsCount")
            case .failure(let error):
                print("Error : \(error)")
            }
        } receiveValue: { [weak self] blogPostCount in
            self?.postCount = blogPostCount
        }.store(in: &subscribedTo)

        
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

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            // Create an instance of the APIManager.
            let apiManager: APIManagerProtocol = APIManager()
            
            // Create an instance of the ViewModel.
            let viewModel = AboutMeViewModel(apiManager: apiManager)
            
            // Create an instance of the AboutMe VC.
            let aboutMeVC = AboutMeViewController(viewModel: viewModel)
            show(aboutMeVC, sender: nil)
        case 1:
            if indexPath.row != 0 {
                let blogDetailVC = BlogDetailViewController()
                blogDetailVC.blogPost = posts[indexPath.row - 1]
                show(blogDetailVC, sender: nil)
            }
        case 2:
            if indexPath.row != 0 {
                let appDetailVC = AppDetailViewController()
                appDetailVC.app = apps[indexPath.row - 1]
                show(appDetailVC, sender: nil)
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
        case 1: return 1 + posts.count // "Blog" section.
        case 2: return 1 + apps.count // "Apps" section.
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
                cell.numberOfPosts = postCount
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
                cell.delegate = self
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AppTableViewCell", for: indexPath) as! AppTableViewCell
                cell.app = apps[indexPath.row - 1]
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
        // Create an instance of the APIManager.
        let apiManager: APIManagerProtocol = APIManager()
        
        // Create an instance of the ViewModel.
        let viewModel = BlogViewModel(apiManager: apiManager)
        
        // Create an instance of Blog VC.
        let blogVC = BlogViewController(viewModel: viewModel)
        show(blogVC, sender: nil)
    }
    
}


// MARK: - Apps Header Cell Actions

extension MainViewController: AppsHeaderCellActions {

    func goToAppsListVC() {
        // Create an instance of the APIManager.
        let apiManager: APIManagerProtocol = APIManager()
        
        // Create an instance of the ViewModel.
        let appsViewModel: AppsViewModel = AppsViewModel(apiManager: apiManager)
        
        // Create an instance of Apps VC.
        let appsVC = AppsViewController(viewModel: appsViewModel)
        show(appsVC, sender: nil)
    }

}
