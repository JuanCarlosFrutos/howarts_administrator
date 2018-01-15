//
//  house.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 29/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation

public class House: Codable {
    
    var name: String
    var id: String
    var alumns: [String]
    var image: String
    
    init() {
        //Generate a unique ID (one per user)
        self.id = UUID().uuidString
        self.name = "Default Name"
        self.alumns = []
        self.image = "default.jpg"
    }
    
}
