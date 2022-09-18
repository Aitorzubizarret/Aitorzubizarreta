//
//  CVViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import Foundation
import Combine

final class CVViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManager?
    
    // Observable subject.
    var cvFile = PassthroughSubject<CVFile, Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    ///
    /// Fetch CVFile from the server, and send them to the View that is observing the 'postSection' observable.
    ///
    func fetchCVFile() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchCVFile { [weak self] result in
            switch result {
            case .success(let cvFile):
                self?.cvFile.send(cvFile)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
