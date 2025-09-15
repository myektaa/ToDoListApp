//
//  CreateTaskController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 13.08.2025.
//

import UIKit

class CreateTaskController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var prioritySection: UISegmentedControl!
    
    var task: Task?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextField.delegate = self
        self.view.backgroundColor = .init(named: "OG Background Color")
        
        //Default value for task
        task = Task(
            date: Date(),
            name: String(),
            priority: .high
        )
        
        task?.priority = Task.TaskPriority(rawValue: prioritySection.selectedSegmentIndex) ?? .medium
        taskTextField.addTarget(self, action: #selector(taskTextFieldDidChange(_:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(animated)
        
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        //Update task's date
        task?.date = sender.date
        print("date \(sender.date)")
    }
    
    @IBAction func segmentedControllerDidChange(_ sender: Any) {
        view.endEditing(true)
        task?.priority = Task.TaskPriority(rawValue: prioritySection.selectedSegmentIndex) ?? .medium
    }
    @objc func taskTextFieldDidChange(_ textField:UITextField){
        task?.name = textField.text ?? "Görev adı yok."
    }
}
    
    extension CreateTaskController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            //Update task's name
            task?.name = textField.text ?? "Görev adı yok."
            return true
    }
}


#Preview {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let createController = storyboard.instantiateViewController(withIdentifier: "CreateTaskController")
    
    
    return createController
}
