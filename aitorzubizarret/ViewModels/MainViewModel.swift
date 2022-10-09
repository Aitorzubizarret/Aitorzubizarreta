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
    
    var unorderedBlogPosts: [BlogPost] = [] {
        didSet {
            var orderedBlogPosts: [BlogPost] = []
            
            // Order the array of posts by date.
            orderedBlogPosts = unorderedBlogPosts.sorted(by: { $0.getFormattedDate() > $1.getFormattedDate() } )
            
            self.blogPosts.send(orderedBlogPosts)
        }
    }
    
    // Observable subjects.
    var blogPosts = PassthroughSubject<[BlogPost], Error>()
    var apps = PassthroughSubject<[App], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetchBlogPosts() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchBlogPosts { [weak self] result in
            switch result {
            case .success(let blogPosts):
                //self?.blogPosts.send(blogPosts)
                self?.unorderedBlogPosts = blogPosts
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
