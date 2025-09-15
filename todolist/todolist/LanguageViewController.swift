//
//  LanguageViewController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 15.09.2025.
//

import UIKit

class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var languages = ["Türkçe","İngilizce"]
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.view.backgroundColor = .init(named: "OG Background Color")
        
        languageTableView.dataSource = self
        languageTableView.delegate = self
        
        view.addSubview(cancelButton)
        view.addSubview(languageTableView)
        languageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "languageCell")
        cancelSetupConstraints()
        languageConstraints()
        
        }
    
    private let cancelButton = {
       let button = UIButton(type: .system)
        let image = UIImage(systemName: "multiply")
        button.setImage(image, for: .normal)
        button.tintColor = .init(named: "Button Color For To Do List")
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func cancelSetupConstraints(){
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -320),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    private let languageTableView = {
       let tableView = UITableView()
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    private func languageConstraints(){
        languageTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languageTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            languageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            languageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            languageTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languageTableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }
    
    
}

#Preview{
    LanguageViewController()
}
