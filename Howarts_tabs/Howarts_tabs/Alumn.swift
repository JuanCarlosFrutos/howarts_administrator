//#imageLiteral(resourceName: "default.jpg")
//  Alumn.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 29/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation

public class Alumn: Codable {
    
    var name: String
    var surname: String
    var house: String
    var image: String
    var id: String
    
    init() {
        self.id = UUID().uuidString
        self.name = self.id
        self.surname = "Surname"
        self.house = "Gryffindor"
        self.image = "default.jpg"
    }
    
    init(house: String){
        self.id = UUID().uuidString
        self.name = self.id
        self.surname = "Surname"
        self.house = house
        self.image = "default.jpg"
    }
    
}
