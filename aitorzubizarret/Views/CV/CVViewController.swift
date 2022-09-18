//
//  CVViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import WebKit
import Combine

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
    
    private var viewModel = CVViewModel(apiManager: APIManager.shared)
    private var subscribedTo: [AnyCancellable] = []
    
    private var cvFile: CVFile? = nil {
        didSet {
            updateWebView()
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscriptions()
        
        initView()
        initActivityIndicator()
        
        viewModel.fetchCVFile()
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
            guard let cvFile = self?.cvFile,
                  let cvFileURL = URL(string: cvFile.pdf) else { return }
            
            self?.hideActivityIndicator()
            
            // Load the PDF into the WebView.
            let myRequest = URLRequest(url: cvFileURL)
            self?.webView.load(myRequest)
            
            self?.pdfURL = cvFileURL
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
    
    private func subscriptions() {
        viewModel.cvFile.sink { error in
            print("Error : \(error)")
        } receiveValue: { [weak self] cvFile in
            self?.cvFile = cvFile
        }.store(in: &subscribedTo)

    }
    
}
