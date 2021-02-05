//
//  PeopleViewController.swift
//  MVPSwift
//  The App Main ViewController (has only one presenter).
//
//  Created by Nanda w Perdana on 1/17/17.
//  Copyright © 2017 Nanda w Perdana. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    let adapter = PeopleAdapter()
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = adapter.self
        view.dataSource = adapter
        view.separatorStyle = .singleLine
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 100
        view.backgroundColor = .white
        view.register(PeopleCell.self, forCellReuseIdentifier: adapter.identifier)
        
        return view
    }()
    
    var safeArea: UILayoutGuide!
    
    let presenter = PeoplePresenter(peopleService: PeopleService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        adapter.delegate = self
        
        view.backgroundColor = .clear
        safeArea = view.layoutMarginsGuide
        
        view.addSubview(listView)
        
        NSLayoutConstraint.activate([
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.leftAnchor.constraint(equalTo: view.leftAnchor),
            listView.rightAnchor.constraint(equalTo: view.rightAnchor),
            listView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // load data
        presenter.getPeople()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PeopleViewController: PeopleAdapterDelegate {
    func didTap(_ item: People) {
        guard let name = item.name else { return }
        showToast(message: "Name: \(name)")
    }
}

extension PeopleViewController: PeopleView {
    func showToast(message: String, duration: Double = 1) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
    
    func startLoading() {
        listView.isHidden = true
    }
    
    func finishLoading() {
        listView.isHidden = false
    }
    
    func setPeople(people: [People]) {
        adapter.list = people
        listView.isHidden = false
        listView.reloadData()
    }
    
    func setEmptyPeople() {
        listView.isHidden = true
    }
}
