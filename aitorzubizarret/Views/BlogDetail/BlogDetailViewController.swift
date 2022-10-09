//
//  BlogDetailViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import UIKit

class BlogDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private weak var tableView: UITableView!
    
    var blogPost: BlogPost? {
        didSet {
            guard let blogPost = blogPost else { return }
            
            print("BlogPost : \(blogPost.title)")
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initTableView()
    }
    
    private func initView() {
        title = "Post"
    }
    
    private func initTableView() {
        let tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        self.tableView = tableView
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Constraints.
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.separatorStyle = .none
        
        // Register cells.
        let titleCellNib = UINib(nibName: "PostSectionTitleTableViewCell", bundle: nil)
        tableView.register(titleCellNib, forCellReuseIdentifier: "PostSectionTitleTableViewCell")
        
        let dateCellNib = UINib(nibName: "PostSectionDateTableViewCell", bundle: nil)
        tableView.register(dateCellNib, forCellReuseIdentifier: "PostSectionDateTableViewCell")
        
        let tagsCellNib = UINib(nibName: "PostSectionTagsTableViewCell", bundle: nil)
        tableView.register(tagsCellNib, forCellReuseIdentifier: "PostSectionTagsTableViewCell")
        
        let descriptionCellNib = UINib(nibName: "PostSectionDescriptionTableViewCell", bundle: nil)
        tableView.register(descriptionCellNib, forCellReuseIdentifier: "PostSectionDescriptionTableViewCell")
    }
    
}

// MARK: - UITableView Delegate

extension BlogDetailViewController: UITableViewDelegate {}

// MARK: - UITableView Data Source

extension BlogDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 // Title, Date, Tags, Descriptions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // Title
        case 1: return 1 // Date
        case 2: return 1 // Tags
        case 3:
            if let blogPost = blogPost {
                return blogPost.descriptions.count
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Title
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionTitleTableViewCell", for: indexPath) as! PostSectionTitleTableViewCell
            if let blogPost = blogPost {
                cell.customTitle = blogPost.title
            }
            return cell
        case 1: // Date
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionDateTableViewCell", for: indexPath) as! PostSectionDateTableViewCell
            if let blogPost = blogPost {
                cell.customDateString = blogPost.date
            }
            return cell
        case 2: // Tags
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionTagsTableViewCell", for: indexPath) as! PostSectionTagsTableViewCell
            if let blogPost = blogPost {
                cell.customTags = blogPost.tags
            }
            return cell
        case 3: // Descriptions
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionDescriptionTableViewCell", for: indexPath) as! PostSectionDescriptionTableViewCell
            if let blogPost = blogPost {
                cell.customDescription = blogPost.descriptions[indexPath.row].description
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
