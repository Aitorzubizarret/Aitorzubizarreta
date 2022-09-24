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
    private let postsSource   = "https://www.aitorzubizarreta.eus/projects/apps-content/aitorzubizarret/jsons/posts-V1.json"
    
    enum UnknownError: Error {
        case unknownError
    }
    
    // MARK: - Methods
    
    func fetchAboutMe(completionHandler: @escaping(Result<[PostSection], Error>) -> Void) {
        guard let aboutMeSourceURL = URL(string: aboutMeSource) else { return }
        
        let task = session.dataTask(with: aboutMeSourceURL) { data, response, error in
            
            if let _ = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                completionHandler(.failure(safeError))
                return
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data: \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let aboutMePostSections = try JSONDecoder().decode([PostSection].self, from: safeData)
                    completionHandler(.success(aboutMePostSections))
                    return
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                    completionHandler(.failure(error))
                    return
                }
            }
            
            completionHandler(.failure(UnknownError.unknownError))
            
        }
        task.resume()
    }
    
    func fetchCVFile(completionHandler: @escaping(Result<CVFile, Error>) -> Void) {
        guard let cvSourceURL = URL(string: cvSource) else { return }
        
        let task = session.dataTask(with: cvSourceURL) { data, response, error in
            
            if let _ = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                completionHandler(.failure(safeError))
                return
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let cvFile = try JSONDecoder().decode(CVFile.self, from: safeData)
                    completionHandler(.success(cvFile))
                    return
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                    completionHandler(.failure(error))
                }
            }
            
            completionHandler(.failure(UnknownError.unknownError))
            
        }
        task.resume()
    }
    
    func fetchAlbumPhotos(completionHandler: @escaping(Result<[Photo], Error>) -> Void) {
        guard let photosSourceURL = URL(string: photosSource) else { return }
        
        let task = session.dataTask(with: photosSourceURL) { data, response, error in
            
            if let _ = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                completionHandler(.failure(safeError))
                return
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data: \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: safeData)
                    completionHandler(.success(photos))
                    return
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                    completionHandler(.failure(error))
                    return
                }
            }
            
            completionHandler(.failure(UnknownError.unknownError))
            
        }
        task.resume()
    }
    
    func fetchBlogPosts(completionHandler: @escaping(Result<[BlogPost], Error>) -> Void) {
        guard let postsSourceURL = URL(string: postsSource) else { return }
        
        let task = session.dataTask(with: postsSourceURL) { data, response, error in
            
            if let _ = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                completionHandler(.failure(safeError))
                return
            }
            
            if let safeData = data {
                // For debug purposes.
                //let receivedData: String = String(data: safeData, encoding: .utf8) ?? ""
                //debugPrint("DebugPrint - Data: \(receivedData) - Response: \(response) - Error: \(error)")
                
                do {
                    let posts = try JSONDecoder().decode([BlogPost].self, from: safeData)
                    completionHandler(.success(posts))
                    return
                } catch let error {
                    print("Error JSONDecoder: \(error)")
                    completionHandler(.failure(error))
                    return
                }
            }
            
            completionHandler(.failure(UnknownError.unknownError))
            
        }
        task.resume()
    }
    
}
