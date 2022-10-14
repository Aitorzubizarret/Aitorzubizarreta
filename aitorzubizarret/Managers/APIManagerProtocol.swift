//
//  APIManagerProtocol.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/10/22.
//

import Foundation

protocol APIManagerProtocol {
    func fetchAboutMe(completionHandler: @escaping(Result<[PostSection], Error>) -> Void )
    func fetchCVFile(completionHandler: @escaping(Result<CVFile, Error>) -> Void)
    func fetchAlbumPhotos(completionHandler: @escaping(Result<[Photo], Error>) -> Void)
    func fetchBlogPosts(completionHandler: @escaping(Result<[BlogPost], Error>) -> Void)
    func fetchApps(completionHandler: @escaping(Result<[App], Error>) -> Void)
}
