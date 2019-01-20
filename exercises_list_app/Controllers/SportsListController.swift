//
//  ViewController.swift
//  exercises_list_app
//
//  Created by Daniel Kilders Díaz on 20/01/2019.
//  Copyright © 2019 dankil. All rights reserved.
//

import UIKit

class SportsListController: UITableViewController {
    
    let baseAPI = "https://wger.de/api/v2/"
    
    // Next page to be loaded
    var nextPage: String? = nil
    
    // Exercises cell ID
    let cellId = "ExerciesesCellIdentifier"
    
    // API retrieved exercises will be stored here
    var exercises = [Exercise]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize nav controller
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Sports List"
        
        // Register custom cell
        tableView.register( UINib(nibName: "ExerciseCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        fetchExercises()
    }
    
    // MARK: - Tableview data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExerciseCell
        
        if let name = exercises[indexPath.row].name {
            cell.exerciseName = name
        }
        
        if let category = exercises[indexPath.row].category {
            cell.exerciseCategory = category
        }
        
        if let muscles = exercises[indexPath.row].muscles {
            cell.exerciseMuscles = muscles
        }
        
        if let equipment = exercises[indexPath.row].equipment {
            cell.exerciseEquipment = equipment
        }
        
        cell.exerciseImageView.image = exercises[indexPath.row].image
        
        return cell
    }
    
    // MARK: - Tableview delegates
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 160)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // another option to update the table
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset: CGFloat = scrollView.contentOffset.y;
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        // Change 50.0 to adjust the distance from bottom
        if (maximumOffset - currentOffset <= 50.0) {
            fetchExercises()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = DetailedExerciseController()
        
        controller.exercise = exercises[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Networking
    
    func fetchExercises() {
        // Set endpoint
        var exercisesEndpoint = ""
        
        // If we haven't retrieved any page, use default URL
        // Otherwise use the retrieved one
        if let nextURL = nextPage {
            exercisesEndpoint = nextURL
        } else {
            exercisesEndpoint = baseAPI + "exercise.json/?language=1"
        }
        print(exercisesEndpoint)
        // Create URL request
        let url = URL(string: exercisesEndpoint)!
        let request = URLRequest(url: url)
        
        // Create the session
        let session = URLSession.shared
        
        // Create the task
        let task = session.dataTask(with: request) { data,response,error in
            
            if let error = error {
                print("Failed with error! \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data else {
                    print("Error retrieving data from the api")
                    return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                self.nextPage = json["next"] as? String
                
                let exercisesJSON = json["results"] as! NSArray
                
                for case let exercise as [String: Any] in exercisesJSON {
                    
                    let name = exercise["name"] as! String
                    let exerciseId = exercise["id"] as! Int
                    let description = exercise["description"] as! String
                    let categoryId = exercise["category"] as! Int
                    let equipmentIds = exercise["equipment"] as! [Int]
                    let musclesIds = exercise["muscles"] as! [Int]
                    
                    self.exercises.append(Exercise(
                        name: name,
                        id: exerciseId,
                        categoryId: categoryId,
                        description: description,
                        equipmentIds: equipmentIds,
                        musclesIds: musclesIds
                    ))
                    
                    self.fetchDetailedInfo(for: self.exercises.count-1, with: exerciseId)
                    self.fetchImage(for: self.exercises.count-1, with: exerciseId)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error serializing JSON")
            }
        }
        task.resume()
    }
    
    func fetchDetailedInfo(for exercisePosition: Int, with id: Int) {
        // Set endpoint
        let detailedInfoEndpoint = baseAPI + "exerciseinfo/\(id)/?format=json&language=1"
        
        // Create URL request
        let url = URL(string: detailedInfoEndpoint)!
        let request = URLRequest(url: url)
        
        // Create the session
        let session = URLSession.shared
        
        // Create the task
        let task = session.dataTask(with: request) { data,response,error in
            
            if let error = error {
                print("Failed with error! \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data else {
                    print("Error retrieving data from the api")
                    return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                // Retrieve category
                let category = json["category"] as! [String: Any]
                let categoryName = category["name"] as! String
                
                // Retrieve muscles
                let musclesJSON = json["muscles"] as! NSArray
                var muscles = [String]()
                for case let muscle as [String: Any] in musclesJSON {
                    let name = muscle["name"] as! String
                    muscles.append(name)
                }
                
                // Retrieve equipment
                let equipmentsJSON = json["equipment"] as! NSArray
                var equipments = [String]()
                for case let equipment as [String: Any] in equipmentsJSON {
                    let name = equipment["name"] as! String
                    equipments.append(name)
                }
                
                // Add retrieved values to exercise
                self.exercises[exercisePosition].category = categoryName
                self.exercises[exercisePosition].muscles = muscles.count == 0
                    ? "Muscles: Not available"
                    : "Muscles: \(muscles.joined(separator:","))"
                self.exercises[exercisePosition].equipment = equipments.count == 0
                    ? "Equipment: None"
                    : "Equipment: \(equipments.joined(separator:","))"
                
                DispatchQueue.main.async {
                    // Reload specific cell
                    let indexPath = IndexPath(row: exercisePosition, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
                
            } catch {
                print("Error serializing JSON")
            }
        }
        task.resume()
    }
    
    func fetchImage(for exercisePosition: Int, with id: Int) {
        // Set endpoint
        let thumbnailEndpoint = baseAPI + "exerciseimage/\(id)/thumbnails/?format=json"
        
        // Create URL request
        let url = URL(string: thumbnailEndpoint)!
        let request = URLRequest(url: url)
        
        // Create the session
        let session = URLSession.shared
        
        // Create the task
        let task = session.dataTask(with: request) { data,response,error in
            
            if let error = error {
                print("Failed with error! \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data else {
                    print("Error retrieving data from the api")
                    return
            }
            
            if data.count <= 2 {
                print("No image available for exercise \(id)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let croppedThumb = json["thumbnail_cropped"] as! [String: Any]
                let imageUrl = croppedThumb["url"] as! String
                
                let url = URL(string: imageUrl)!
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    self.exercises[exercisePosition].image = UIImage(data: imageData)
                }
                
                
                DispatchQueue.main.async {
                    // Reload specific cell
                    let indexPath = IndexPath(row: exercisePosition, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                
            } catch {
                print("Error retrieving image from API")
            }
        }
        task.resume()
    }
}

