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
        
        // Using static images as I have not been able to find any endpoint that provides a variety of images.
        // Only the endpoint of the main image
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
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: collectionCellId)
    }
}

extension DetailedExerciseController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! ImagesCollectionViewCell
        
        cell.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = self.view.frame.width - 16 // minus the margin we have given in the nib
        return CGSize(width: screenWidth, height: 100)
    }
}
