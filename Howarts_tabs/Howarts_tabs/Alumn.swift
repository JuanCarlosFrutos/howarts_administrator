//
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
    var image: URL
    var id: String
    
    init() {
        //Generate a unique ID (one per user)
        self.id = UUID().uuidString
        self.name = "Name: " + self.id
        self.surname = "Surname"
        self.house = "House"
        self.image = URL.init(string:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg")!
    }
    
    init(house: String){
        self.id = UUID().uuidString
        self.name = "Name: " + self.id
        self.surname = "Surname"
        self.house = house
        self.image = URL.init(string:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg")!
    }
    
}
