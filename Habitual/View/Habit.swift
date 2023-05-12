//
//  Habit.swift
//  Habitual
//
//  Created by Student Guest on 3/13/23.
//
import UIKit
import Foundation

struct Habit: Codable {
    enum Images: Int, CaseIterable, Codable {
        case book
        case bulb
        case clock
        case code
        case drop
        case food
        case grow
        case gym
        case heart
        case lotus
        case other
        case pet
        case pill
        case search
        case sleep
        case tooth
        
        var image: UIImage {
            guard let image = UIImage(named: String(describing: self)) else {
                fatalError("image \(self) not founnd")
            }
            
            return image
        }
    }
    var title: String
    var dateCreated: Date = Date()
    var selectedImage: Habit.Images
    var currentStreak: Int = 0
    var bestStreak: Int = 0
    var lastCompletionDate: Date?
    var numberOfCompletions: Int = 0
    var completedToday: Bool {
        return lastCompletionDate?.isToday ?? false
    }
    
    init(title: String, image: Habit.Images) {
        self.title = title
        self.selectedImage = image
        
    }
}
