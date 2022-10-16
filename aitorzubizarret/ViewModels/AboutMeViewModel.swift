//
//  AboutMeViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import Foundation
import Combine

final class AboutMeViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManagerProtocol
    
    // Observable subject.
    var postSections = PassthroughSubject<[PostSection], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    ///
    /// Fetch Post Sections from the server, and send them to the View that is observing the 'postSection' observable.
    ///
    func fetchPostSections() {
        apiManager.fetchAboutMe { [weak self] result in
            switch result {
            case .success(let postSections):
                self?.postSections.send(postSections)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
