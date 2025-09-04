//
//  HomeViewController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 12.08.2025.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var isFavourite: Bool = false
    var checked = false
    var done = false
    
    private let buttonSize = CGFloat(60)
    
    
    @IBOutlet weak var tableView: UITableView!

    let store = TaskStore.shared
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)

        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.image = UIImage(systemName: "plus")
        button.configuration?.imagePadding = 8
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        view.addSubview(addButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = buttonSize / 2
        setupConstraints()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addButton.heightAnchor.constraint(equalToConstant: buttonSize),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupAction() {
        addButton.addTarget(self, action: #selector(deneme), for: .touchUpInside)
    }
    
    @objc private func deneme() {
        print("Ekleme menüsü açıldı...")
        performSegue(withIdentifier: "listToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToDetail" {
               
        } else if segue.identifier == "listToEdit" {
            if let editVC = segue.destination as? EditTaskController,
               let indexPath = sender as? IndexPath {
                if indexPath.section == 0 {
                    editVC.task = store.favoriteTasks[indexPath.row]
                } else if indexPath.section == 1{
                    editVC.task = store.todoTasks[indexPath.row]
                } else {
                    editVC.task = store.completedTasks[indexPath.row]
                }
                editVC.editedIndexPath = indexPath
            }
        }
    }
    
    @IBAction func saveTaskButtonTapped(segue: UIStoryboardSegue) {
        print("Görev Ekleniyor...")
        
        guard let createTaskController = segue.source as? CreateTaskController, let createdTask = createTaskController.task else {
            fatalError("CreateTaskController'a ulaşılmaya çalışırken hata oluştu.")
        }
        
        store.addTask(task: createdTask)
        
        //Create indexPath to be inserted to tableview
        let indexPath = IndexPath(row: 0, section: 1)
        
        //Use indexPath to insert into the tableview
        tableView.insertRows(at: [indexPath], with: .automatic)
        print("Eklendi")
    }
    
    @IBAction func updateTaskButtonTapped(segue: UIStoryboardSegue) {
        print("Görev Düzenleniyor...")
        
        guard let editTaskController = segue.source as? EditTaskController,
              let editTask = editTaskController.task,
              let editedIndexPath = editTaskController.editedIndexPath else {
            fatalError("EditTaskController'a ulaşılmaya çalışırken hata oluştu.")
        }
        
        do {
            try store.updateTask(newTask: editTask)
            
            tableView.reloadData()
            
            print("Düzenleniyor")
        } catch let error {
            print(error)
        }
    }
}
    
    extension HomeViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return store.favoriteTasks.count
            } else if section == 1 {
                return store.todoTasks.count
            } else {
                return store.completedTasks.count
            }
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section{
            case 0:
                return "Favori Görevler"
            case 1:
                return "Görevler"
            case 2:
                return "Biten Görevler"
            default:
                return nil
            }
        }

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            // Hücreyi kenarlardan inset ile ayır
            cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(
                top: 5,
                left: 16,
                bottom: 5,
                right: 16
            ))
//            cell.contentView.layer.cornerRadius = 12
//            cell.contentView.layer.masksToBounds = true
//            cell.backgroundColor = UIColor(
//                red: 253 / 255,
//                green: 126 / 255,
//                blue: 20 / 255,
//                alpha: 1.0
//            )
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr_TR")
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
//            cell.backgroundColor = UIColor(
//                red: 253 / 255,
//                green: 126 / 255,
//                blue: 20 / 255,
//                alpha: 1.0
//            )
//            cell.textLabel?.numberOfLines = 0
//            cell.clipsToBounds = true
//            cell.layer.cornerRadius = 20
            cell.selectionStyle = .none
//            cell.contentView.frame.inset(
//                by: UIEdgeInsets(
//                    top: 8,
//                    left: 8,
//                    bottom: 8,
//                    right: 8
//                ))
            let task: Task
            if indexPath.section == 0 {
                task = store.favoriteTasks[indexPath.row]
            } else if indexPath.section == 1 {
                task = store.todoTasks[indexPath.row]
            } else {
                task = store.completedTasks[indexPath.row]
            }

            cell.taskLabel?.text = task.name
            cell.dateLabel?.text = formatter.string(from: task.date)
            
            if indexPath.section == 0 {
                cell.favLabel.text = "⭐️"
            } else if indexPath.section == 1 {
                cell.favLabel.text = ""
            } else {
                cell.favLabel.text = "✅"
            }
            
            return cell
    }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let task = taskToOperate(for: indexPath)
                
                do {
                    try store.removeTask(withUUID: task.uuid)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } catch let error {
                    print(error)
                }
            }
        }
        
        func taskToOperate(for indexPath: IndexPath) -> Task {
            let taskToOperate: Task
            if indexPath.section == 0 {
                taskToOperate = store.favoriteTasks[indexPath.row]
            } else if indexPath.section == 1 {
                taskToOperate = store.todoTasks[indexPath.row]
            } else {
                taskToOperate = store.completedTasks[indexPath.row]
            }
            return taskToOperate
        }
    }

extension HomeViewController: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil")
        { (action, view, completion) in
            let task = self.taskToOperate(for: indexPath)
            do {
                try self.store.removeTask(withUUID: task.uuid)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            } catch let error {
                completion(false)
            }
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let editAction = UIContextualAction(style: .normal, title: "Düzenle")
        { (action, view, completion) in
            self.performSegue(withIdentifier: "listToEdit", sender: indexPath)
        }
        editAction.backgroundColor = .blue
        editAction.image = UIImage(systemName: "pencil")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favoriAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            var task = self.taskToOperate(for: indexPath)
            task.isFavorited.toggle()
            do {
                try self.store.updateTask(newTask: task)
                tableView.reloadData()
                completion(true)
            } catch let error {
                completion(false)
            }
            
        }
        if indexPath.section == 0 {
            favoriAction.image = UIImage(systemName: "star.slash")
        } else if indexPath.section == 2 {
            favoriAction.image = UIImage(systemName: "star")
        } else {
            favoriAction.image = UIImage(systemName: "star")
        }
        favoriAction.backgroundColor = .systemYellow
        
        let finishAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            var task = self.taskToOperate(for: indexPath)
            task.isCompleted.toggle()
            do {
                try self.store.updateTask(newTask: task)
                tableView.reloadData()
                completion(true)
            } catch let error {
                completion(false)
            }
        }
        if indexPath.section == 0 {
            finishAction.image = UIImage(systemName: "checkmark.circle")
        } else if indexPath.section == 2 {
            finishAction.image = UIImage(systemName: "checkmark.circle.fill")
        }
        else {
            finishAction.image = UIImage(systemName: "checkmark.circle")
        }
        finishAction.backgroundColor = .systemGreen
        
        if indexPath.section == 2{
            return UISwipeActionsConfiguration(actions: [finishAction])
        }
        
        return UISwipeActionsConfiguration(actions: [favoriAction,finishAction])
    }
    
}

#Preview {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let homeController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
    
    return homeController
}
