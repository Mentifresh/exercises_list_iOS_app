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
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var exercise: Exercise?
    var images: [UIImage] = [UIImage()]
    let collectionCellId = "collectionCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let image = exercise!.image!
        images = [image,image,image,image]
        
        
        configureTableview()
        
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
    
    func configureTableview() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
    }
}

extension DetailedExerciseController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! ImagesCollectionViewCell
        
        // FIXME: fix crash when assigning image
//        cell.image = images[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    
}
