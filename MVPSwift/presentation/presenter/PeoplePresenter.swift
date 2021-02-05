//
//  PeoplePresenter.swift
//  MVPSwift
//  The ViewController's presenter, contains:
//      - View: The ViewController's contract.
//      - Presenter: The ViewController's main logic (call API, populate data, show data, etc.)
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import UIKit

protocol PeopleView: NSObjectProtocol {
    func showToast(message: String, duration: Double)
    func startLoading()
    func finishLoading()
    func setPeople(people: [People])
    func setEmptyPeople()
}

class PeoplePresenter {
    private let peopleService: PeopleService
    weak private var peopleView: PeopleView?
    
    init(peopleService: PeopleService) {
        self.peopleService = peopleService
    }
    
    func attachView(view: PeopleView) {
        peopleView = view
    }
    
    func detachView() {
        peopleView = nil
    }
    
    func getPeople() {
        peopleView?.startLoading()
        peopleService.callAPIGetPeople(
            onSuccess: { [weak self] people in
                guard let ws = self else { return }
                ws.peopleView?.finishLoading()
                if (people.count == 0){
                    ws.peopleView?.setEmptyPeople()
                } else {
                    ws.peopleView?.setPeople(people: people)
                }
            },
            onFailure: { [weak self] errorMessage in
                self?.peopleView?.finishLoading()
            }
        )
    }
}
