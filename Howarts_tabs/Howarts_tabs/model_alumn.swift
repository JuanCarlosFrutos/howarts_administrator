//
//  model_alumn.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 29/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation
import UIKit

public class Model_alumn {
    
    var name: String
    var surname: String
    var house: String
    var image: UIImage
    
    var myImage = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
    
    init() {
        name = "name"
        surname = "surname"
        house = "house"
        image = myImage!
    }
    
}
