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
    }
    
    
    init(ArrayAlums: [Alumn], ArrayHouse: [House]) {
        ArrayAlums.forEach({self.dictionaryAlumns[$0.id] = $0})
        ArrayHouse.forEach({self.dictionaryHouses[$0.id] = $0})
    }
    
    func loadAlumns() {
        let jsonDecoder = JSONDecoder()
        var alumns = [Alumn]()
        var allData: Data = Data.init()
        
        do {
            allData = try String(contentsOf: PATH_ALUMNS, encoding: .utf8).data(using: .utf8)!
        }
        catch let error{debugPrint(error.localizedDescription)}
        
        do{
            alumns = try jsonDecoder.decode([Alumn].self, from: allData)
        }
        catch let error{debugPrint(error.localizedDescription)}
        
        alumns.forEach({
            print($0.name)
            print($0.house)
        })
        
    }
    
    
    
    func save() {
        
    }
    
}

