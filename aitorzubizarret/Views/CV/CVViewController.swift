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
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: webConfiguration)
        
        view.addSubview(webview)
        
        // Constraints.
        let safeArea: UILayoutGuide = view.layoutMarginsGuide
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        webview.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        webview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        webview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        return webview
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private lazy var shareBarButton: UIBarButtonItem = {
        let sharePDFBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(sharePDF))
        navigationItem.rightBarButtonItems = [sharePDFBarButton]
        return sharePDFBarButton
    }()
    private var pdfURL: URL? {
        didSet {
            guard let _ = pdfURL else { return }
            
            shareBarButton.isEnabled = true
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
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
    
    private func initActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
        
        showActivityIndicator()
    }
    
    @objc private func updateWebView() {
        DispatchQueue.main.async { [weak self] in
            guard let safeCVFile = DataManager.shared.cvFile,
                  let safeCVFileURL = URL(string: safeCVFile.pdf) else { return }
            
            self?.hideActivityIndicator()
            
            // Load the PDF into the WebView.
            let myRequest = URLRequest(url: safeCVFileURL)
            self?.webView.load(myRequest)
            
            self?.pdfURL = safeCVFileURL
        }
    }
    
    @objc private func sharePDF() {
        guard let safePDFUrl = pdfURL else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [safePDFUrl], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}