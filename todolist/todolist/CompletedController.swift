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
    var doneTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneTableView.dataSource = self
        doneTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDoneTaskAdded), name: Notification.Name("doneTaskAdded"), object: nil)
        
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func handleDoneTaskAdded(_ notification: Notification) {
        guard let task = notification.object as? Task else { return }
        self.doneTasks.insert(task, at: 0)
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
            if section == 0 {
                return doneTasks.count
            } else {
                return doneTasks.count
            }
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section{
            case 0:
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
            
            let doneCell = tableView.dequeueReusableCell(withIdentifier: "DoneCell", for: indexPath) as! DoneCell
            let tasks = doneTasks[indexPath.row]

            doneCell.doneLabel?.text = tasks.name
            doneCell.doneDateLabel?.text = formatter.string(from: tasks.date)
            doneCell.markLabel?.text = "✅"
            
            return doneCell
    }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if indexPath.section == 0 {
                    doneTasks.remove(at: indexPath.row)
                }
                doneTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
}

extension CompletedController: UITableViewDelegate {

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Sil")
        { [self] (action, view, completion) in
            if indexPath.section == 0 {
                self.doneTasks.remove(at: indexPath.row)
            }
            doneTableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
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

