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
            allBlogPosts = sortBlogPostByDate(allBlogPosts: allBlogPosts)
            
            // Get 4 or less posts.
            allBlogPosts = filterArrayByQuantity(elements: allBlogPosts, quantity: 4)
            
            self.blogPosts.send(allBlogPosts)
            self.blogPostsCount.send(totalBlogPosts)
        }
    }
    var allApps: [App] = [] {
        didSet {
            self.apps.send(filterArrayByQuantity(elements: allApps, quantity: 3))
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
    
    func fetchBlogPosts() {
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
        apiManager.fetchApps { [weak self] result in
            switch result {
            case .success(let apps):
                self?.allApps = apps
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
    ///
    /// Orders the array of blog posts by date.
    ///
    func sortBlogPostByDate(allBlogPosts: [BlogPost]) -> [BlogPost] {
        return allBlogPosts.sorted(by: { $0.getFormattedDate() > $1.getFormattedDate() } )
    }
    
    func filterArrayByQuantity<T>(elements: [T], quantity: Int) -> [T] {
        return elements.count > quantity ? Array(elements.prefix(quantity)) : elements
    }
    
}
