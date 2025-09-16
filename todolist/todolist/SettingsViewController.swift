//
//  ProfileViewController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 9.09.2025.
//

import Foundation
import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingsOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var models = [Section]()
    
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
    
    private let titleLabel = {
       let title = UILabel()
        title.text = NSLocalizedString("BIG_SETTINGS_TITLE", comment: "Big settings title in settings")
        title.textColor = .init(named: "Text Color For To Do List")
        title.font = .systemFont(ofSize: 30, weight: .bold)
        return title
    }()
    
    private func titleConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
    }
    
    private let settingsTableView = {
       let tableView = UITableView()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = settingsTableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = settingsTableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.selectionStyle = .none
            cell.mySwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            return cell
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        guard let window = UIApplication.shared.windows.first else { return }

        UIView.animate(withDuration: 5) {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
            if model.title == "Hakkında" || model.title == "About" {
                performSegue(withIdentifier: "aboutSection", sender: self)
            } else if model.title == "Dil" || model.title == "Language" {
                changeLanguage()
            }
        case .switchCell(let model):
            model.handler()
        }
        
    }
    
    func changeLanguage() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableViewConfigure(){
        models.append(Section(title: NSLocalizedString("SETTINGS_GENERAL_TITLE", comment: "General big title in settings"), options: [
            .switchCell(model: SettingsSwitchOption(title: NSLocalizedString("SETTINGS_MODE_TITLE", comment: "Mode title in settings"), icon: UIImage(systemName: "sun.max.fill"), iconBackgroundColor: .systemFill, handler: {
            }, isOn: true)),
            .staticCell(model: SettingsOption(title: NSLocalizedString("SETTINGS_LANGUAGE_TITLE", comment: "Language title in settings"), icon: UIImage(systemName: "globe"), iconBackgroundColor: .systemGreen) {
            })
        ]))
        models.append(Section(title: NSLocalizedString("SETTINGS_ABOUTUS_TITLE", comment: "About Us title in settings"), options: [
            .staticCell(model: SettingsOption(title: NSLocalizedString("SETTINGS_ABOUT_TITLE", comment: "About title in settings"), icon: UIImage(systemName: "info.circle"), iconBackgroundColor: .systemBlue) {
            }),
            .staticCell(model: SettingsOption(title: NSLocalizedString("SETTINGS_RATETHEAPP_TITLE", comment: "Rate the App title in settings"), icon: UIImage(systemName: "medal.star"), iconBackgroundColor: .systemYellow) {
            })
        ]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    private func tvConstraints(){
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        self.view.backgroundColor = .init(named: "OG Background Color")
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        view.addSubview(cancelButton)
        view.addSubview(settingsTableView)
        view.addSubview(titleLabel)
        tableViewConfigure()
        tvConstraints()
        cancelSetupConstraints()
        titleConstraints()
        
    }
    
}

#Preview {
    
    let storyboards = UIStoryboard(name: "Main", bundle: nil)
    
    let profileVC = storyboards.instantiateViewController(withIdentifier: "ProfileViewController")
    return profileVC
}
