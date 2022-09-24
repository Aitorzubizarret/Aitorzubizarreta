//
//  BlogViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import Foundation
import Combine

final class BlogViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManager?
    
    // Observable object.
    var blogPosts = PassthroughSubject<[BlogPost], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetchBlogPosts() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchBlogPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.blogPosts.send(posts)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
