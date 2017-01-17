//
//  ContactViewController.swift
//  MVPSwift
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
}

class ContactViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = ContactPresenter(contactService: ContactService())
    var contactToDisplay = [ContactViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        
        presenter.attachView(view: self)
        presenter.getContacts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        let contactViewData = contactToDisplay[indexPath.row]
        cell.labelTitle?.text = contactViewData.name
        cell.labelSubtitle?.text = contactViewData.email
        return cell
    }
}

extension ContactViewController: ContactView {
    
    func startLoading() {
        // Show your loader
    }
    
    func finishLoading() {
        // Dismiss your loader
    }
    
    func setContacts(contacts: [ContactViewData]) {
        contactToDisplay = contacts
        tableView?.isHidden = false
        tableView?.reloadData()
    }
    
    func setEmptyContact() {
        tableView?.isHidden = true
    }
}
