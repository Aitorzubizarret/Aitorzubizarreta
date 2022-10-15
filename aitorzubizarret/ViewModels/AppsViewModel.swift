//
//  AppsViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import Foundation
import Combine

final class AppsViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManagerProtocol
    
    // Observable object.
    var apps = PassthroughSubject<[App], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchApps() {
        apiManager.fetchApps { [weak self] result in
            switch result {
            case .success(let apps):
                self?.apps.send(apps)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
