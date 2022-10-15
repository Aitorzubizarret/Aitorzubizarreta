//
//  BlogViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 15/10/22.
//

import Foundation
import Combine


final class BlogViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManagerProtocol
    
    var allBlogPosts: [BlogPost] = [] {
        didSet {
            // Order the array of posts by date.
            allBlogPosts = allBlogPosts.sorted(by: { $0.getFormattedDate() > $1.getFormattedDate() } )
            
            self.blogPosts.send(allBlogPosts)
        }
    }
    
    // Observable object.
    var blogPosts = PassthroughSubject<[BlogPost], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchBlogs() {
        apiManager.fetchBlogPosts { [weak self] result in
            switch result {
            case .success(let blogPosts):
                self?.allBlogPosts = blogPosts
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
