//
//  UserService.swift
//  MVPSwift
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import Foundation

class ContactService {
    
    func callAPIGetContacts(onSuccess successCallback: ((_ contacts: [ContactsModel]) -> Void)?,
                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        APICallManager.instance.callAPIGetContacts(
            onSuccess: { (contacts) in
                successCallback?(contacts)
        },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
        })
    }
}
