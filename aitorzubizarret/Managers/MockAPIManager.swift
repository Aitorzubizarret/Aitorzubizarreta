//
//  MockAPIManager.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/10/22.
//

import Foundation

final class MockAPIManager {
    
    var mockPostSections: [PostSection]
    var mockCVFile: CVFile
    var mockPhotos: [Photo]
    var mockBlogPosts: [BlogPost]
    var mockApps: [App]
    
    init(mockPostSections: [PostSection], mockCVFile: CVFile, mockPhotos: [Photo], mockBlogPosts: [BlogPost], mockApps: [App]) {
        self.mockPostSections = mockPostSections
        self.mockCVFile = mockCVFile
        self.mockPhotos = mockPhotos
        self.mockBlogPosts = mockBlogPosts
        self.mockApps = mockApps
    }
    
}

extension MockAPIManager: APIManagerProtocol {
    
    func fetchAboutMe(completionHandler: @escaping (Result<[PostSection], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completionHandler(.success(self.mockPostSections))
        })
    }
    
    func fetchCVFile(completionHandler: @escaping (Result<CVFile, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completionHandler(.success(self.mockCVFile))
        })
    }
    
    func fetchAlbumPhotos(completionHandler: @escaping (Result<[Photo], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completionHandler(.success(self.mockPhotos))
        })
    }
    
    func fetchBlogPosts(completionHandler: @escaping (Result<[BlogPost], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completionHandler(.success(self.mockBlogPosts))
        })
    }
    
    func fetchApps(completionHandler: @escaping (Result<[App], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completionHandler(.success(self.mockApps))
        })
    }
    
}
