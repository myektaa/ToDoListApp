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
    var favoriteTasks = [Task]()
    var normalTasks = [Task]()
    var doneTasks = [Task]() // core data veya UserDefaults
    
    
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
                    editVC.task = favoriteTasks[indexPath.row]
                } else if indexPath.section == 1{
                    editVC.task = normalTasks[indexPath.row]
                } else {
                    editVC.task = doneTasks[indexPath.row]
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
        
        //Insert into normalTasks array
        normalTasks.insert(createdTask, at: 0) //Top of the normalTasks array
        
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
        
        if editedIndexPath.section == 0 {
            favoriteTasks[editedIndexPath.row] = editTask
        } else if editedIndexPath.section == 1 {
            normalTasks[editedIndexPath.row] = editTask
        } else {
            doneTasks[editedIndexPath.row] = editTask
        }
        
        tableView.reloadRows(at: [editedIndexPath], with: .automatic)

        print("Düzenleniyor")
    }

}
    
    extension HomeViewController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return favoriteTasks.count
            } else if section == 1 {
                return normalTasks.count
            } else {
                return doneTasks.count
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
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr_TR")
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
            let task: Task
            if indexPath.section == 0 {
                task = favoriteTasks[indexPath.row]
            } else if indexPath.section == 1 {
                task = normalTasks[indexPath.row]
            } else {
                task = doneTasks[indexPath.row]
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
                if indexPath.section == 0 {
                    favoriteTasks.remove(at: indexPath.row)
                } else if indexPath.section == 1 {
                    normalTasks.remove(at: indexPath.row)
                } else {
                    doneTasks.remove(at: indexPath.row)
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
}

extension HomeViewController: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil")
        { (action, view, completion) in
            if indexPath.section == 0 {
                self.favoriteTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                self.normalTasks.remove(at: indexPath.row)
            } else {
                self.doneTasks.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
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
            if indexPath.section == 1 {
                let task = self.normalTasks.remove(at: indexPath.row)
                self.favoriteTasks.insert(task, at: 0)
            } else if indexPath.section == 2 {
                let task = self.doneTasks.remove(at: indexPath.row)
                self.favoriteTasks.insert(task, at: 0)
            } else {
                let task = self.favoriteTasks.remove(at: indexPath.row)
                self.normalTasks.insert(task, at: 0)
            }
            tableView.reloadData()
            completion(true)
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
            if indexPath.section == 1 {
                let task = self.normalTasks.remove(at: indexPath.row)
                NotificationCenter.default.post(name: Notification.Name("doneTaskAdded"), object: task)
                self.doneTasks.insert(task, at: 0)
            } else if indexPath.section == 0 {
                let task = self.favoriteTasks.remove(at: indexPath.row)
                NotificationCenter.default.post(name: Notification.Name("doneTaskAdded"), object: task)
                self.doneTasks.insert(task, at: 0)
            } else {
                let task = self.doneTasks.remove(at: indexPath.row)
                NotificationCenter.default.post(name: Notification.Name("doneTaskRemoved"), object: task)
                self.normalTasks.insert(task, at: 0)
            }
            tableView.reloadData()
            completion(true)
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
        
        return UISwipeActionsConfiguration(actions: [favoriAction,finishAction])
    }
    
}

#Preview {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let homeController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
    
    return homeController
}
