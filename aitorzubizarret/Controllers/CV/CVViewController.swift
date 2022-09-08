//
//  CVViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import WebKit

class CVViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    private var webView: WKWebView?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initWebView()
        initActivityIndicator()
        
        DataManager.shared.getCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWebView), name: Notification.Name("CV"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CV"), object: nil)
    }
    
    private func initView() {
        title = "CV"
    }
    
    private func initWebView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        guard let safeWebView = webView else { return }
        
        view.addSubview(safeWebView)
        
        // Constraints.
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        
        safeWebView.translatesAutoresizingMaskIntoConstraints = false
        
        safeWebView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        safeWebView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        safeWebView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        safeWebView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func initActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
        
        showActivityIndicator()
    }
    
    @objc private func updateWebView() {
        DispatchQueue.main.async { [weak self] in
            guard let safeWebView = self?.webView,
                  let safeCVFile = DataManager.shared.cvFile,
                  let safeCVFileURL = URL(string: safeCVFile.pdf) else { return }
            
            self?.hideActivityIndicator()
            
            let myRequest = URLRequest(url: safeCVFileURL)
            safeWebView.load(myRequest)
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}
