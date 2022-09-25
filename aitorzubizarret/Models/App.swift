//
//  App.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/9/22.
//

import Foundation

struct App: Codable {
    
    // MARK: - Properties
    
    let title: String
    let description: String
    let appStoreId: String
    
    // MARK: - Methods
    
    func getAppStoreURL() -> String {
        return "https://apps.apple.com/es/app/\(appStoreId)?platform=iphone"
    }
    
}
