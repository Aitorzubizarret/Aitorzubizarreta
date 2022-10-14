//
//  AboutMeViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import Combine

class AboutMeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let viewModel = AboutMeViewModel(apiManager: APIManager())
    private var subscribedTo: [AnyCancellable] = []
    
    private var postSections: [PostSection] = [] {
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
        initActivityIndicator()
        
        viewModel.fetchPostSections()
    }
    
    private func initView() {
        title = "Sobre mí"
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
        
        let postSectionCVCell = UINib(nibName: "PostSectionCVTableViewCell", bundle: nil)
        tableView.register(postSectionCVCell, forCellReuseIdentifier: "PostSectionCVTableViewCell")
        
        let postSectionContactButtonNib = UINib(nibName: "PostSectionContactButtonTableViewCell", bundle: nil)
        tableView.register(postSectionContactButtonNib, forCellReuseIdentifier: "PostSectionContactButtonTableViewCell")
    }
    
    private func initActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
        
        showActivityIndicator()
    }
    
    @objc private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivityIndicator()
            self?.tableView.reloadData()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func subscriptions() {
        viewModel.postSections.sink { error in
            print("Error \(error)")
        } receiveValue: { [weak self] postSections in
            self?.postSections = postSections
        }.store(in: &subscribedTo)

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
        return self.postSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postSection: PostSection = postSections[indexPath.row]
        
        if let image = postSection.image {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionImageTableViewCell", for: indexPath) as! PostSectionImageTableViewCell
            cell.customPhotoURLString = image
            return cell
        } else if let title  = postSection.title {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionTitleTableViewCell", for: indexPath) as! PostSectionTitleTableViewCell
            cell.customTitle = title
            return cell
        } else if let subtitle = postSection.subtitle {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionSubtitleTableViewCell", for: indexPath) as! PostSectionSubtitleTableViewCell
            cell.customSubtitle = subtitle
            return cell
        } else if let quote = postSection.quote {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionQuoteTableViewCell", for: indexPath) as! PostSectionQuoteTableViewCell
            cell.customQuote = quote
            return cell
        } else if let description = postSection.description {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionDescriptionTableViewCell", for: indexPath) as! PostSectionDescriptionTableViewCell
            cell.customDescription = description
            return cell
        } else if let _ = postSection.cvButton {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionCVTableViewCell", for: indexPath) as! PostSectionCVTableViewCell
            cell.delegate = self
            return cell
        } else if let _ = postSection.contactButton {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionContactButtonTableViewCell", for: indexPath) as! PostSectionContactButtonTableViewCell
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

// MARK: - PostSection CV Cell Actions

extension AboutMeViewController: PostSectionCVCellActions {
    
    func goToCVDetailVC() {
        let cvDetailVC = CVViewController()
        show(cvDetailVC, sender: nil)
    }
    
}

// MARK: - PostSection Contact Cell Actions

extension AboutMeViewController: PostSectionContactButtonCellActions {
    
    func goToContactDetailVC() {
        let contactDetailVC = ContactMeViewController()
        show(contactDetailVC, sender: nil)
    }
    
}
