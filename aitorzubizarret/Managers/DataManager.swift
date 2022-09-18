//
//  DataManager.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 16/8/22.
//

import Foundation

final class DataManager {
    
    // MARK: - Properties
    
    static var shared = DataManager()
    
    var cvFile: CVFile? = nil {
        didSet {
            guard let _ = cvFile else { return }
            
            NotificationCenter.default.post(name: Notification.Name("CV"), object: nil)
        }
    }
    var photos: [Photo] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("Photos"), object: nil)
        }
    }
    var blogPosts: [BlogPost] = []
    
    // MARK: - Methods
    
    func getPhotos() {
        APIManager.shared.getPhotos()
    }
    
    func getCV() {
        APIManager.shared.getCV()
    }
    
    func clearAllData() {
        cvFile = nil
        photos = []
    }
    
}
