//
//  AppDetailViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 2/10/22.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    var app: App? {
        didSet {
            guard let app = app else { return }
            
            print("App title: \(app.title)")
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        title = "App"
    }
    
}
