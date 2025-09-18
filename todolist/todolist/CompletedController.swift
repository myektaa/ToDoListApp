//
//  CompletedController.swift
//  todolist
//
//  Created by MustafaYektaTaraf on 14.08.2025.
//

import UIKit

import Foundation
import UIKit

class CompletedController: UIViewController {
        

    @IBOutlet weak var doneTableView: UITableView!
    let store = TaskStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneTableView.dataSource = self
        doneTableView.delegate = self
                
        self.view.backgroundColor = .init(named: "OG Background Color")
        self.doneTableView.backgroundColor = .init(named: "OG Backgronund Color")
        doneTableView.separatorStyle = .none
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneTableView.reloadData()
    }
}
    
    extension CompletedController: UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return store.completedTasks.count
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section{
            case 0:
                return NSLocalizedString("COMPLETED_TASKS_IN_COMPLETED", comment: "Completed Tasks in completed section")
            default:
                return nil
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "tr_TR")
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            
            let doneCell = tableView.dequeueReusableCell(withIdentifier: "DoneCell", for: indexPath) as! DoneCell
            let tasks = store.completedTasks[indexPath.row]
            
            doneCell.selectionStyle = .none

            doneCell.doneLabel.numberOfLines = 0
            doneCell.doneLabel?.text = tasks.name
            doneCell.doneDateLabel?.text = formatter.string(from: tasks.date ?? Date())
            doneCell.markLabel?.text = "✅"
            
            return doneCell
    }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if indexPath.section == 0 {
                    let task = store.completedTasks[indexPath.row]
                    do {
                        try store.removeTask(withItem: task)
                        doneTableView.deleteRows(at: [indexPath], with: .automatic)
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        
}

extension CompletedController: UITableViewDelegate {

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil")
        { [self] (action, view, completion) in
            if indexPath.section == 0 {
                let task = self.store.completedTasks[indexPath.row]
                do {
                    try self.store.removeTask(withItem: task)
                } catch let error {
                    print(error)
                }
            }
            doneTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        deleteAction.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        
        deleteAction.backgroundColor = .systemBackground
        deleteAction.title = "Sil"
        deleteAction.backgroundColor = .init(named: "OG Background Color")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

#Preview {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let completedController = storyboard.instantiateViewController(withIdentifier: "CompletedController")
    
    return completedController
}

