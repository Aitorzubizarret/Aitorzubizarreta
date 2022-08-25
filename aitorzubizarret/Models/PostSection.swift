//
//  PostSection.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 25/8/22.
//

import Foundation
import UIKit

struct PostSection: Codable {
    
    // MARK: - Properties
    
    let image: String?
    let title: String?
    let subtitle: String?
    let quote: String?
    let description: String?
    
    // MARK: - Methods
    
    func getCustomTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let _ = image {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionImageTableViewCell", for: indexPath) as! PostSectionImageTableViewCell
            var content = cell.defaultContentConfiguration()
            content.text = "Image"
            cell.contentConfiguration = content
            return cell
        } else if let _  = title {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionTitleTableViewCell", for: indexPath) as! PostSectionTitleTableViewCell
            var content = cell.defaultContentConfiguration()
            content.text = "Title"
            cell.contentConfiguration = content
            return cell
        } else if let _ = subtitle {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionSubtitleTableViewCell", for: indexPath) as! PostSectionSubtitleTableViewCell
            var content = cell.defaultContentConfiguration()
            content.text = "Subtitle"
            cell.contentConfiguration = content
            return cell
        } else if let _ = quote {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionQuoteTableViewCell", for: indexPath) as! PostSectionQuoteTableViewCell
            var content = cell.defaultContentConfiguration()
            content.text = "Quote"
            cell.contentConfiguration = content
            return cell
        } else if let _ = description {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostSectionDescriptionTableViewCell", for: indexPath) as! PostSectionDescriptionTableViewCell
            var content = cell.defaultContentConfiguration()
            content.text = "Description"
            cell.contentConfiguration = content
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
