//
//  MainViewController.swift
//  Habitual
//
//  Created by Student Guest on 3/11/23.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    private var persistence = PersistenceLayer()
        override func viewDidLoad() {
        tableView.register(
          HabitTableViewCell.nib,
          forCellReuseIdentifier: HabitTableViewCell.identifier
        )
        super.viewDidLoad()
        setupNavBar() // Call the new method
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.habits.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HabitTableViewCell.identifier,
            for: indexPath
          ) as! HabitTableViewCell
        let habit = persistence.habits[indexPath.row]
          cell.configure(habit) // Shows an error, you'll fix this next!
          return cell
                    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHabit = persistence.habits[indexPath.row]
        let habitDetailVC = HabitDetailViewController.instantiate()
        habitDetailVC.habit = selectedHabit
        habitDetailVC.habitIndex = indexPath.row
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let habitToDelete = persistence.habits[indexPath.row]
            let habitIndexToDelete = indexPath.row
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                self.persistence.delete(habitIndexToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      persistence.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
}

extension HabitsTableViewController {
    
    func setupNavBar(){
        title = "Habitual"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
extension UIAlertController {
    convenience init(habitTitle: String, confirmHandler: @escaping () -> Void) {
        self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            confirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)

    }
}


