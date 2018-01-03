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
    var houses = [House]()
    private var NAME_OF_FILE_ALUMNS = ""
    private var NAME_OF_FILE_HOUSES = ""
    private var PATH_ALUMNS: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var PATH_HOUSES: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init() {
        NAME_OF_FILE_ALUMNS = "howarts_data_alumns.json"
        NAME_OF_FILE_HOUSES = "howarts_data_houses.json"
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        debugPrint(documentsURL)
        PATH_ALUMNS = documentsURL.appendingPathComponent(NAME_OF_FILE_ALUMNS)
        PATH_HOUSES = documentsURL.appendingPathComponent(NAME_OF_FILE_HOUSES)
        PATH_ALUMNS = URL.init(string: "file:///Users/jcarlos/Documents/howarts_data_alumns.json")!
        PATH_HOUSES = URL.init(string: "file:///Users/jcarlos/Documents/howarts_data_houses.json")!
        loadHouses()
        loadAlumns()
        // alumnsByHouse()
    }
    
    
    init(ArrayAlums: [Alumn], ArrayHouse: [House]) {
        ArrayAlums.forEach({self.dictionaryAlumns[$0.id] = $0})
        self.houses = ArrayHouse
    }
    
    func loadAlumns() {
        let jsonDecoder = JSONDecoder()
        var alumns = [Alumn]()
        var allData: Data = Data.init()
        
        do {
            allData = try String(contentsOf: PATH_ALUMNS, encoding: .utf8).data(using: .utf8)!
            alumns = try jsonDecoder.decode([Alumn].self, from: allData)
        }
        catch let error{debugPrint(error.localizedDescription)}
    
        alumns.forEach({self.dictionaryAlumns[$0.id] = $0})
        alumnsByHouse()
    }

    func loadHouses() {
        let jsonDecoder = JSONDecoder()
        var allData: Data = Data.init()
        
        do {
            allData = try String(contentsOf: PATH_HOUSES, encoding: .utf8).data(using: .utf8)!
            self.houses = try jsonDecoder.decode([House].self, from: allData)
        }
        catch let error{debugPrint(error.localizedDescription)}
    }
    
    
    
    func saveAlumns() {
        let jsonEncoder = JSONEncoder()
        var data: Data = Data.init()
        var arrayAlumn = [Alumn]()
        
        for (_, alumn) in self.dictionaryAlumns {
            arrayAlumn.append(alumn)
        }
        do {
            data = try jsonEncoder.encode(arrayAlumn)
            try data.write(to: self.PATH_ALUMNS, options: [])
        }
        catch let error{debugPrint(error.localizedDescription)}
    }
    
    func alumnsByHouse() {
        self.houses.forEach({$0.alumns = []})
        for (id, alumn) in self.dictionaryAlumns {
            self.houses.forEach({
                if alumn.house == $0.name {
                    $0.alumns.append(id)
                    $0.numberAlumns = $0.alumns.count
                }
            })
        }
    }
    
}

