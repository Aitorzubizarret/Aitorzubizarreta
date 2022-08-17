//
//  UIImageView+Extension.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 16/8/22.
//

import UIKit

extension UIImageView {
    
    ///
    /// Downloads image data from a URL, creates a UIImage, and loads it into a UIImageView.
    ///
    func download(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let safeError = error {
                print("Error \(safeError.localizedDescription)")
                return
            }
            
            if let safeResponse = response {
                //print("Response \(safeResponse)")
            }
            
            if let safeData = data {
                guard let image = UIImage(data: safeData) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
        task.resume()
        
    }
    
}
