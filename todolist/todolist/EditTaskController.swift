//
//  EditTaskController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 17.08.2025.
//

import UIKit

class EditTaskController: UIViewController {
    
    @IBOutlet weak var editField: UITextField!
    @IBOutlet weak var editDatePicker: UIDatePicker!
    @IBOutlet weak var editPriority: UISegmentedControl!
    
    private let buttonSize = CGFloat(60)
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.configuration = .filled()
        
        button.configuration?.background.backgroundColor = .init(named: "Button Color For To Do List")
        
        button.configuration?.baseBackgroundColor = .lightText
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24)
        
        
        button.configuration?.image = UIImage(systemName: "square.and.arrow.down")
        button.configuration?.imagePadding = 8
        button.configuration?.imagePlacement = .leading
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        
        button.setTitle("Kaydet", for: .normal)
        button.clipsToBounds = true
         
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(saveButton)
        saveButton.layer.cornerRadius = buttonSize / 2
        setupAction()
        setupConstraints()
        editPriority.removeAllSegments()
                        
        editField.delegate = self
        editField.addTarget(self, action: #selector(editFieldDidChange(_:)), for: .editingChanged)

        for (index, priority) in Task.TaskPriority.allCases.enumerated() {
            editPriority.insertSegment(withTitle: priority.name, at: index, animated: false)
        }
    }
    
    
    private func setupConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        let trailingAnchor = saveButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8)
        trailingAnchor.priority = .defaultLow
        NSLayoutConstraint.activate([
        saveButton.heightAnchor.constraint(equalToConstant: buttonSize),
        saveButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
        saveButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
        trailingAnchor,
        saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -60)
        ])
    }
    
    private func setupAction(){
        saveButton.addTarget(self, action: #selector(kaydet), for: .touchUpInside)
    }
    
    @objc private func kaydet(){
        task.name = editField.text ?? "Görev adı yok."
        task.date = editDatePicker.date
        task.priority = Task.TaskPriority(rawValue: editPriority.selectedSegmentIndex) ?? .medium
        performSegue(withIdentifier: "updateTaskButtonTappedWithSegue", sender: nil)
        print("Save Button")
    }
    
    @objc private func editFieldDidChange(_ textField: UITextField) {
        task.name = textField.text ?? "Görev adı yok."
    }
    
    var task: Task!
    var editedIndexPath: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editField.text = task.name
        editPriority.selectedSegmentIndex = task.priority.rawValue
        editDatePicker.date = task.date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        task.name = editField.text ?? ""
        task.date = editDatePicker.date
        
    }
}

extension EditTaskController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //Update task's name
        task?.name = textField.text ?? "Görev adı yok."
        return true
}
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        task?.name = textField.text ?? "Görev adı yok."
    }
}

@available(iOS 17.0, *)
#Preview {
    
    let storyboards = UIStoryboard(name: "Main", bundle: nil)
    
    let editController = storyboards.instantiateViewController(withIdentifier: "EditTaskController") as! EditTaskController
    editController.task = Task.sampleTask
    return editController
}
