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
                self?.blogPosts.send(blogPosts)
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
