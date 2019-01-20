//
//  Exercise.swift
//  exercises_list_app
//
//  Created by Daniel Kilders Díaz on 20/01/2019.
//  Copyright © 2019 dankil. All rights reserved.
//

import Foundation
import UIKit

class Exercise {
    
    let name: String?
    let id: Int?
    let categoryId: Int?
    let equipmentIds: [Int]?
    let musclesIds: [Int]?
    let description: String?
    
    var image = UIImage(named: "no_icon")
    var category: String? = nil
    var imageURL: String? = nil
    var exerciseImagesURL: [String]? = nil
    var muscles: String? = nil
    var equipment: String? = nil
    
    required init(name: String, id: Int, categoryId: Int, description: String?, equipmentIds: [Int]?, musclesIds: [Int]?) {
        self.name = name
        self.id = id
        self.categoryId = categoryId
        self.equipmentIds = equipmentIds
        self.musclesIds = musclesIds
        self.description = description
    }
}
