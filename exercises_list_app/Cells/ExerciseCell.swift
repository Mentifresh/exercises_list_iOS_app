//
//  ExerciseCell.swift
//  exercises_list_app
//
//  Created by Daniel Kilders Díaz on 20/01/2019.
//  Copyright © 2019 dankil. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var ExerciseCategoryLabel: UILabel!
    @IBOutlet weak var ExerciseEquipmentLabel: UILabel!
    @IBOutlet weak var ExerciseMusclesLabel: UILabel!
    
    var exerciseName: String = "" {
        didSet {
            exerciseNameLabel.text = exerciseName
        }
    }
    
    var exerciseCategory: String = "" {
        didSet {
            ExerciseCategoryLabel.text = exerciseCategory
        }
    }
    
    var exerciseEquipment: String = "" {
        didSet {
            ExerciseEquipmentLabel.text = exerciseEquipment
        }
    }
    
    var exerciseMuscles: String = "" {
        didSet {
            ExerciseMusclesLabel.text = exerciseMuscles
        }
    }
}
