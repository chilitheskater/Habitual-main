//
//  HabitTableViewCell.swift
//  Habitual
//
//  Created by Student Guest on 3/13/23.
//

import UIKit



class HabitTableViewCell: UITableViewCell {
    // Set the identifier for the custom cell
    static let identifier = "HabitCell"
    // Returning the xib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(_ habit: Habit) {
      self.imageViewIcon.image = habit.selectedImage.image
      self.labelHabitTitle.text = habit.title
      self.labelStreaks.text = "streak: \(habit.currentStreak)"

      if habit.completedToday {
        self.accessoryType = .checkmark
      } else {
        self.accessoryType = .disclosureIndicator
      }
    }
    
}
