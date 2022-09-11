//
//  ContactMeViewController.swift
//  aitorzubizarret
//
//  Created by Aitor Zubizarreta on 14/8/22.
//

import UIKit
import MessageUI  // Used for opening Mail app and to create a new mail when the user taps on the email address.
import ContactsUI // Used for opening Contacts app with the CNContactViewController on screen and filled with my contact data.

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
        checkContactsPermission()
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

// MARK: - Contacts

extension ContactMeViewController {
    
    ///
    /// Opens iPhone Settings  to change the Contacts permission for this App.
    ///
    private func openSettings(alert: UIAlertAction!) {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    ///
    /// Checks if the App has permission to access to Contacts.
    /// If the App does NOT have permission, it will display an alert view with an option to go to iPhone Settings.
    ///
    private func checkContactsPermission() {
        CNContactStore().requestAccess(for: .contacts) { access, error in
            if access {
                DispatchQueue.main.async {
                    self.addNewContact()
                }
            } else {
                DispatchQueue.main.async {
                    let alertMessage = UIAlertController(title: "Error",
                                                         message: "La app no tiene permiso para acceder a Contactos.",
                                                         preferredStyle: .alert)

                    alertMessage.addAction(UIAlertAction(title: "Ir a Ajustes",
                                                         style: UIAlertAction.Style.default,
                                                         handler: self.openSettings))
                    alertMessage.addAction(UIAlertAction(title: "Cerrar",
                                                         style: UIAlertAction.Style.default,
                                                         handler: nil))
                    
                    self.present(alertMessage, animated: true)
                }
                
                print("Error \(String(describing: error))")
            }
        }
    }
    
    ///
    /// Tries to save a new Contact in Contacts.
    ///
    private func addNewContact() {
        // Create the mutable contact object.
        let contact = CNMutableContact()
        
        let imageData = UIImage(named: "Me")?.pngData()
        contact.imageData = imageData
        
        contact.givenName = "Aitor"
        contact.familyName = "Zubizarreta Perez"
        
        contact.jobTitle = "iOS Developer"
        
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "aitorzubizarreta@yahoo.es" as NSString)
        contact.emailAddresses = [workEmail]
        
        let personalWeb = CNLabeledValue(label: CNLabelURLAddressHomePage, value: "https://www.aitorzubizarreta.eus" as NSString)
        contact.urlAddresses = [personalWeb]
        
        var birthday = DateComponents()
        birthday.day = 25
        birthday.month = 4
        birthday.year = 1984
        contact.birthday = birthday
        
        let postalAddress = CNMutablePostalAddress()
        postalAddress.city = "Madrid"
        postalAddress.country = "Spain"
        
        contact.postalAddresses = [CNLabeledValue(label:CNLabelWork, value:postalAddress)]
        
        contact.note = "Contacto agregado desde la app 'aitorzubizarret' de la AppStore."
        
        // Display the original ContactViewController with my contact data on it.
        let contactVC = CNContactViewController(forNewContact: contact)
        contactVC.contactStore = CNContactStore()
        contactVC.delegate = self
        
        let navController: UINavigationController = UINavigationController(rootViewController: contactVC)
        present(navController, animated: true)
    }
    
}

// MARK: - CNContact ViewController.

extension ContactMeViewController: CNContactViewControllerDelegate {
    
    func contactViewController(_ viewController: CNContactViewController, shouldPerformDefaultActionFor property: CNContactProperty) -> Bool {
        return true
    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        dismiss(animated: true)
    }
    
}
