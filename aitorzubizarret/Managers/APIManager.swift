//
//  APIManager.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 16/8/22.
//

import Foundation

final class APIManager {
    
    // MARK: - Properties
    
    static let shared = APIManager()
    
    private let photosSource = "https://www.aitorzubizarreta.eus/jsons/aitorzubizarret/photos-V1.json"
    
    // MARK: - Methods
    
    func getPhotos() {
        
        guard let photosSourceURL = URL(string: photosSource) else { return }
        
        let task = URLSession.shared.dataTask(with: photosSourceURL) { data, response, error in
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                return
            }
            
            if let safeResponse = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data: \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: safeData)
                    DataManager.shared.photos = photos
                    
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                }
            }
            
        }
        task.resume()
    }
    
}
