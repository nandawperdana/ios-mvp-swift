//
//  ContactPresenter.swift
//  MVPSwift
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Foundation

struct ContactViewData{
    let name: String
    let email: String
}

protocol ContactView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setContacts(contacts: [ContactViewData])
    func setEmptyContact()
}

class ContactPresenter {
    private let contactService:ContactService
    weak private var contactView : ContactView?
    
    init(contactService:ContactService){
        self.contactService = contactService
    }
    
    func attachView(view:ContactView){
        contactView = view
    }
    
    func detachView() {
        contactView = nil
    }
    
    func getContacts(){
        self.contactView?.startLoading()
        contactService.callAPIGetContacts(
            onSuccess: { (contacts) in
                self.contactView?.finishLoading()
                if (contacts.count == 0){
                    self.contactView?.setEmptyContact()
                } else {
                    let mappedUsers = contacts.map {
                        return ContactViewData(name: "\($0.name!)", email: "\($0.email!)")
                    }
                    self.contactView?.setContacts(contacts: mappedUsers)
                }
        }, onFailure: { (errorMessage) in
            
        })
    }
}
