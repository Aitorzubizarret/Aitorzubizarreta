//
//  PhotoAlbumViewModel.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 18/9/22.
//

import Foundation
import Combine
import UIKit

final class PhotoAlbumViewModel {
    
    // MARK: - Properties
    
    var apiManager: APIManager?
    
    // Observable object.
    var photos = PassthroughSubject<[Photo], Error>()
    
    // MARK: - Methods
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    ///
    /// Fetch Album Photos from the server, and send them to the View that is observing the 'photos' observable.
    ///
    func fetchAlbumPhotos() {
        guard let apiManager = apiManager else { return }
        
        apiManager.fetchAlbumPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos.send(photos)
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
}
