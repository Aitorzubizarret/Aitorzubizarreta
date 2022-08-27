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
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.ephemeral // Doesn't persist data.
        let session = URLSession(configuration: configuration)
        return session
    }
    
    private let aboutMeSource = "https://www.aitorzubizarreta.eus/projects/apps-content/aitorzubizarret/jsons/aboutme-V1.json"
    private let photosSource  = "https://www.aitorzubizarreta.eus/projects/apps-content/aitorzubizarret/jsons/photos-V1.json"
    
    // MARK: - Methods
    
    func getPhotos() {
        guard let photosSourceURL = URL(string: photosSource) else { return }
        
        let task = session.dataTask(with: photosSourceURL) { data, response, error in
            
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
    
    func getAboutMe() {
        guard let aboutMeSourceURL = URL(string: aboutMeSource) else { return }
        
        let task = session.dataTask(with: aboutMeSourceURL) { data, response, error in
            
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
                    let aboutMePostSections = try JSONDecoder().decode([PostSection].self, from: safeData)
                    DataManager.shared.aboutMePostSections = aboutMePostSections
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                }
            }
            
        }
        task.resume()
    }
    
}
