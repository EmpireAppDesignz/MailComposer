//
//  ViewController.swift
//  EmailComposer
//
//  Created by Eric Rosas on 11/27/18.
//  Copyright © 2018 Eric Rosas. All rights reserved.
//

import UIKit
//https://developer.apple.com/documentation/messageui/mfmailcomposeviewcontroller
//Framework required to add mail form
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //IBAction to open standard email interface
    @IBAction func emailButtonDidTouch(_ sender: UIButton) {
        
        //The mail composition interface
        //Use your own email address & subject
        let receipients = ["Eric@empireappdesignz.com"]
        let subject = "Your App Name"
        let messageBody = ""
        
        let configuredMailComposeViewController = configureMailComposeViewController(recepients: receipients, subject: subject, messageBody: messageBody)
        
        //Checking the availability of mail services
        if canSendMail() {
            self.present(configuredMailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
}

//MFMailComposeViewController Delegate
extension ViewController: MFMailComposeViewControllerDelegate {
    
    //Configuring and presenting the composition interface
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func configureMailComposeViewController(recepients: [String], subject: String, messageBody: String) -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(recepients)
        mailComposerVC.setSubject(subject)
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        sendMailErrorAlert.addAction(cancelAction)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    

}

