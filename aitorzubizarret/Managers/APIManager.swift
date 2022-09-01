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
    private let cvSource      = "https://www.aitorzubizarreta.eus/projects/apps-content/aitorzubizarret/jsons/cv-V1.json"
    private let photosSource  = "https://www.aitorzubizarreta.eus/projects/apps-content/aitorzubizarret/jsons/photos-V1.json"
    
    // MARK: - Methods
    
    func getAboutMe() {
        guard let aboutMeSourceURL = URL(string: aboutMeSource) else { return }
        
        let task = session.dataTask(with: aboutMeSourceURL) { data, response, error in
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                return
            }
            
            if let _ = response {
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
    
    func getCV() {
        guard let cvSourceURL = URL(string: cvSource) else { return }
        
        let task = session.dataTask(with: cvSourceURL) { data, response, error in
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                return
            }
            
            if let _ = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let cvFile = try JSONDecoder().decode(CVFile.self, from: safeData)
                    DataManager.shared.cvFile = cvFile
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                }
            }
            
        }
        task.resume()
    }
    
    func getPhotos() {
        guard let photosSourceURL = URL(string: photosSource) else { return }
        
        let task = session.dataTask(with: photosSourceURL) { data, response, error in
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                return
            }
            
            if let _ = response {
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
