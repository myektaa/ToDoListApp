//
//  ProfileViewController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 9.09.2025.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate {
    
    private let buttonSize = CGFloat(60)
    
    private let switchButton = {
        let button = UISwitch()
        return button
    }()
    
    private func setupConstraints() {
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchButton.widthAnchor.constraint(equalToConstant: buttonSize),
            switchButton.heightAnchor.constraint(equalToConstant: buttonSize),
            switchButton.leadingAnchor.constraint(equalTo: changeModeLabel.leadingAnchor, constant: 160),
            switchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 460)
        ])
    }
    
    private func checkSwitchButton() {
        switchButton.addTarget(self, action:  #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
            if sender.isOn {
                changeModeLabel.text = "🌙 Koyu Mod"
            } else {
                changeModeLabel.text = "☀️ Açık Mod"
            }
    }
    
    private let changeModeLabel = {
        let modeLabel = UILabel()
        modeLabel.text = "☀️ Açık Mod"
        return modeLabel
    }()
    
    private func labelSetupConstraints() {
        changeModeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            changeModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            changeModeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 465)
        ])
    }
    
    private let languagePopUpButton = {
        let languageButton = UIButton(type: .system)
        languageButton.backgroundColor = .init(named: "Button Color For To Do List")
        languageButton.tintColor = .white
        return languageButton
    }()
    
    func setupLanguageButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)}
        
        languagePopUpButton.menu = UIMenu(children: [
            UIAction(title: "Türkçe", state: .on, handler: optionClosure),
            UIAction(title: "İngilizce", state: .on, handler: optionClosure)
        ])
    
        languagePopUpButton.showsMenuAsPrimaryAction = true
        languagePopUpButton.changesSelectionAsPrimaryAction = true
        
        
        languagePopUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languagePopUpButton.widthAnchor.constraint(equalToConstant: 100),
            languagePopUpButton.heightAnchor.constraint(equalToConstant: 30),
            languagePopUpButton.leadingAnchor.constraint(equalTo: languageLabel.leadingAnchor, constant: 135),
            languagePopUpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 535)
        ])
    }
    
    private let languageLabel = {
       let languageLabel = UILabel()
        languageLabel.text = "🌍 Dil"
        return languageLabel
    }()
    
    private func languageLabelSetupConstraints(){
        languageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            languageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 540)
        ])
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
    
    private let settingsTableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private func settingTVSetupConstraints(){
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsTableView.widthAnchor.constraint(equalToConstant: 300),
            settingsTableView.heightAnchor.constraint(equalToConstant: 500),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150)
        ])
                }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        self.view.backgroundColor = .init(named: "OG Background Color")
        
//        view.addSubview(changeModeLabel)
//        view.addSubview(switchButton)
//        view.addSubview(languagePopUpButton)
//        languagePopUpButton.layer.cornerRadius = buttonSize / 4
//        view.addSubview(languageLabel)
        view.addSubview(cancelButton)
        view.addSubview(settingsTableView)
        settingTVSetupConstraints()
        cancelSetupConstraints()
//        languageLabelSetupConstraints()
//        setupConstraints()
//        labelSetupConstraints()
//        checkSwitchButton()
//        setupLanguageButton()
        
    }
    
}

#Preview {
    
    let storyboards = UIStoryboard(name: "Main", bundle: nil)
    
    let profileVC = storyboards.instantiateViewController(withIdentifier: "ProfileViewController")
    return profileVC
}
