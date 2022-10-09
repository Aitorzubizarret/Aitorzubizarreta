//
//  BlogPost.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 11/9/22.
//

import Foundation

struct BlogPost: Codable {
    
    // MARK: - Properties
    
    let title: String
    let date: String
    let tags: [BlogTag]
    let descriptions: [BlogDescription]
    
    // MARK: - Methods
    
    ///
    /// Formatts the received date and returns a Date.
    /// Ex: Received 2022-10-09T09:27:00+0200 -> Returns 2022/10/09 11:27 (Date)
    ///
    func getFormattedDate() -> Date? {
        // Date Formatter: String -> Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // 2022-10-09T09:27:00+0200
        let dateFormatted: Date? = dateFormatter.date(from: date)
        
        return dateFormatted
    }
    
    ///
    /// Formatts the received date and returns an String.
    /// Ex: Received 2022-10-09T09:27:00+0200 -> Returns 2022/10/09 11:27 (String)
    ///
    func getFormattedDate() -> String {
        // Date Formatter: String -> Date
        let dateFormatter = DateFormatter()
        
        let dateFormatted: Date? = getFormattedDate()
        
        guard let dateFormatted = dateFormatted else { return "" }
        
        // Date Formatter: Date -> Custom String
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let stringDateFormatted: String = dateFormatter.string(from: dateFormatted)
        
        return stringDateFormatted
    }
    
}
