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
    let appStoreProductId: String
    
    // MARK: - Methods
    
    static func createWebAddress(appStoreProductId: String) -> String {
        return "https://apps.apple.com/es/app/id" + "\(appStoreProductId)"
    }
    
}
