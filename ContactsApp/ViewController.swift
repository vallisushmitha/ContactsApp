//
//  ViewController.swift
//  ContactsApp
//
//  Created by Narendra Kumar on 9/21/16.
//  Copyright © 2016 Narendra Kumar. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    let store = CNContactStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        store.requestAccess(for: .contacts, completionHandler: {
            granted, error in
            
            guard granted else {
                let alert = UIAlertController(title: "Can't access contact", message: "Please go to Settings -> MyApp to enable contact permission", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
            var cnContacts = [CNContact]()
            
            do {
                try self.store.enumerateContacts(with: request){
                    (contact, cursor) -> Void in
                    cnContacts.append(contact)
                }
            } catch let error {
                NSLog("Fetch contact error: \(error)")
            }
            
            NSLog(">>>> Contact list:")
            for contact in cnContacts {
                let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? "No Name"
                NSLog("\(fullName): \(contact.phoneNumbers.description)")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

