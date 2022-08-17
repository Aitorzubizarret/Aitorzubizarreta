//
//  Photo.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 16/8/22.
//

import Foundation

struct Photo: Codable {
    let originalURL: String
    let thumbnailURL: String
    let title: String
    let description: String
    let creationDate: String
    let location: String
}
