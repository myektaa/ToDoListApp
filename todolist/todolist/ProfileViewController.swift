//
//  ProfileViewController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 9.09.2025.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    
    private let switchSize = CGFloat(60)
    
    private let modeLabel = {
        let label = UILabel()
        label.text = "Tema değişikliği için butona tıklayınız."
        return label
    }
    
    private let switchButton = {
        let button = UISwitch()
        return button
    }()
    
    private func setupConstraints() {
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: switchSize),
            switchButton.heightAnchor.constraint(equalToConstant: switchSize),
            switchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            switchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180)
        ])
    }
    
//    private func labelSetupConstraints() {
//        modeLabe
//    
//    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        self.view.backgroundColor = .init(named: "OG Background Color")
        
        view.addSubview(modeLabel())
        view.addSubview(switchButton)
        switchButton.layer.cornerRadius = switchSize / 2
        setupConstraints()
//        labelSetupConstraints()
        
        
         }
    
}

#Preview {
    
    let storyboards = UIStoryboard(name: "Main", bundle: nil)
    
    let profileVC = storyboards.instantiateViewController(withIdentifier: "ProfileViewController")
    return profileVC
}
