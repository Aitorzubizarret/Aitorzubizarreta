//
//  BlogPost.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/9/22.
//

import Foundation

struct BlogPost: Codable {
    let title: String
    let date: String
    let tags: [BlogTag]
    let descriptions: [BlogDescription]
}
