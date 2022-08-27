//
//  ContactMeViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import MessageUI // Used for opening Mail app and to create a new mail when the user taps on the email address.
import AddressBookUI //

class ContactMeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var myPhotoBorderImageView: UIImageView!
    @IBOutlet weak var myPhotoImageView: UIImageView!
    
    @IBOutlet weak var emailButton: UIButton!
    @IBAction func emailButtonTapped(_ sender: Any) {
        goToEmail()
    }
    
    @IBOutlet weak var linkedinButton: UIButton!
    @IBAction func linkedinButtonTapped(_ sender: Any) {
        goToLinkedin()
    }
    
    @IBOutlet weak var githubButton: UIButton!
    @IBAction func githubButtonTapped(_ sender: Any) {
        goToGithub()
    }
    
    @IBOutlet weak var downloadContactButton: UIButton!
    
    @IBAction func downloadContactButtonTapped(_ sender: Any) {
        downloadContact()
    }
    
    // MARK: - Properties
    
    private let linkedinWeb = "https://es.linkedin.com/in/aitorzubizarret"
    private let linkedinApp = "linkedin://profile/aitorzubizarret"
    private let githubWeb   = "https://github.com/Aitorzubizarret"
    private let githubApp   = "github://user/Aitorzubizarret"
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func initView() {
        title = "Contacta conmigo"
        
        // View.
        mainView.backgroundColor = UIColor.white
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(named: "myGrey")?.cgColor
        mainView.layer.cornerRadius = 6
        
        mainView.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        mainView.layer.shadowColor = UIColor(named: "myDarkGrey")?.cgColor
        mainView.layer.shadowRadius = 6
        mainView.layer.shadowOpacity = 0.2
        
        // ImageViews.
        myPhotoBorderImageView.layer.cornerRadius = 55
        myPhotoImageView.layer.cornerRadius = 50
        
        // Button.
        downloadContactButton.layer.cornerRadius = 6
    }
    
    private func goToLinkedin() {
        if let appURL = URL(string: linkedinApp),
           let webURL = URL(string: linkedinWeb) {
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func goToGithub() {
        if let appURL = URL(string: githubApp),
            let webURL = URL(string: githubWeb) {
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    ///
    /// Downloads the contact information to user's Contacts app.
    ///
    private func downloadContact() {
        
    }
    
}

// MARK: - MFMailCompose ViewController Delegate

extension ContactMeViewController: MFMailComposeViewControllerDelegate {
    
    ///
    /// Opens the Mail app to create an email with the recipient's address (my email address).
    ///
    private func goToEmail() {
        let recipientEmail = "aitorzubizarreta@yahoo.es"
        let subject = "Quiero contactar contigo Aitor"
        let body = ""
        
        // Show default email composer.
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
        } else {
            // TODO: Support different email apps.
            
            UIPasteboard.general.string = recipientEmail
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
