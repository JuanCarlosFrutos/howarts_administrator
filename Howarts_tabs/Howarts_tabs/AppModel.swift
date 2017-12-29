//
//  AppModel.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 29/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation

public class AppModel {
    
    var dictionaryAlumns = Dictionary<String, Alumn>()
    var dictionaryHouses = Dictionary<String, House>()
    
    init() {}
    
    init(ArrayAlums: [Alumn], ArrayHouse: [House]) {
        ArrayAlums.forEach({self.dictionaryAlumns[$0.id] = $0})
        ArrayHouse.forEach({self.dictionaryHouses[$0.id] = $0})
    }
    
    
    
}

