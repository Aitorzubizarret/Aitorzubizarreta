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
    
    var apiManager: APIManagerProtocol
    
    var allBlogPosts: [BlogPost] = [] {
        didSet {
            let totalBlogPosts: Int = allBlogPosts.count
            
            // Order the array of posts by date.
            allBlogPosts = allBlogPosts.sorted(by: { $0.getFormattedDate() > $1.getFormattedDate() } )
            
            // Get 4 or less posts.
            if allBlogPosts.count > 4 {
                allBlogPosts = Array(allBlogPosts.prefix(4))
            }
            
            self.blogPosts.send(allBlogPosts)
            self.blogPostsCount.send(totalBlogPosts)
        }
    }
    var allApps: [App] = [] {
        didSet {
            // Get 3 or less apps.
            if allApps.count > 3 {
                allApps = Array(allApps.prefix(3))
            }
            
            self.apps.send(allApps)
        }
    }
    
    // Observable subjects.
    var blogPosts = PassthroughSubject<[BlogPost], Error>()
    var blogPostsCount = PassthroughSubject<Int, Error>()
    var apps = PassthroughSubject<[App], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetch4BlogPosts() {
        apiManager.fetchBlogPosts { [weak self] result in
            switch result {
            case .success(let blogPosts):
                self?.allBlogPosts = blogPosts
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
    func fetch4Apps() {
        apiManager.fetchApps { [weak self] result in
            switch result {
            case .success(let apps):
                self?.allApps = apps
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
