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
    
    var aboutMePostSections: [PostSection] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("AboutMe"), object: nil)
        }
    }
    var photos: [Photo] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("Photos"), object: nil)
        }
    }
    // MARK: - Methods
    
    func getPhotos() {
        APIManager.shared.getPhotos()
    }
    
    func getAboutMe() {
        APIManager.shared.getAboutMe()
    }
    
}
