//
//  AboutVC.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 15.09.2025.
//

import UIKit

class AboutVC: UIViewController {
    
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
    
    private let aboutTableView = {
       let tableView = UITableView()
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    private func tvConstraints(){
        aboutTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            aboutTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            aboutTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            aboutTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            aboutTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(named: "OG Background Color")
        
        view.addSubview(aboutTableView)
        view.addSubview(cancelButton)
        tvConstraints()
        cancelSetupConstraints()
        
         }
}

#Preview {
    
    let storyboards = UIStoryboard(name: "Main", bundle: nil)
    
    let aboutVC = storyboards.instantiateViewController(withIdentifier: "AboutVC")
    return aboutVC
}
