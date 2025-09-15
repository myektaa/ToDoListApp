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
            aboutTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            aboutTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            aboutTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            aboutTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private let titleLabel = {
       let title = UILabel()
        title.text = NSLocalizedString("ABOUT_SECTION_TITLE", comment: "About title in about section")
        title.textColor = .black
        title.font = .systemFont(ofSize: 30, weight: .bold)
        return title
    }()
    
    private func titleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
    }
    
    private let captionLabel = {
        let caption = UILabel()
        caption.text = NSLocalizedString("ABOUT_CAPTION", comment: "About caption")
        caption.textColor = .black
        caption.font = .systemFont(ofSize: 16, weight: .regular)
        caption.numberOfLines = 0
        return caption
    }()
    
    private func captionLabelConstraints(){
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(named: "OG Background Color")
        
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(captionLabel)
        cancelSetupConstraints()
        titleConstraints()
        captionLabelConstraints()
        
         }
}

#Preview {
    AboutVC()
}
