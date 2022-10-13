//
//  MainViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import Foundation
import Combine

final class MainViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManager?
    
    var allBlogPosts: [BlogPost] = [] {
        didSet {
            // Order the array of posts by date.
            allBlogPosts = allBlogPosts.sorted(by: { $0.getFormattedDate() > $1.getFormattedDate() } )
            
            // Get 4 or less for the MainViewController.
            if allBlogPosts.count > 4 {
                allBlogPosts = Array(allBlogPosts.prefix(4))
            }
            
            self.blogPosts.send(allBlogPosts)
        }
    }
    
    // Observable subjects.
    var blogPosts = PassthroughSubject<[BlogPost], Error>()
    var apps = PassthroughSubject<[App], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetch4BlogPosts() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchBlogPosts { [weak self] result in
            switch result {
            case .success(let blogPosts):
                self?.allBlogPosts = blogPosts
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
    func fetchApps() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchApps { [weak self] result in
            switch result {
            case .success(let apps):
                self?.apps.send(apps)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
