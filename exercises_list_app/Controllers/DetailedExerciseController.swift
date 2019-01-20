//
//  DetailedExerciseController.swift
//  exercises_list_app
//
//  Created by Daniel Kilders Díaz on 20/01/2019.
//  Copyright © 2019 dankil. All rights reserved.
//

import UIKit

class DetailedExerciseController: UIViewController {
    
    @IBOutlet weak var exerciseImageview: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseCategoryLabel: UILabel!
    @IBOutlet weak var exerciseDescriptionLabel: UILabel!
    @IBOutlet weak var exerciseEquipmentLabel: UILabel!
    @IBOutlet weak var exerciseMusclesLabel: UILabel!
    
    var exercise: Exercise?
    
    var exerciseImage: UIImage?
    var exerciseName: String?
    var exerciseCategory: String?
    var exerciseDescription: String?
    var exerciseEquipment: String?
    var exerciseMuscles: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        addContent()
    }
    
    func addContent() {
        if let exercise = exercise {
            exerciseImageview.image = exercise.image
            title = exercise.name
            exerciseNameLabel.text = exercise.name
            exerciseCategoryLabel.text = exercise.category
            exerciseDescriptionLabel.text = exercise.description
            exerciseEquipmentLabel.text = exercise.equipment
            exerciseMusclesLabel.text = exercise.muscles
        }
    }
}
