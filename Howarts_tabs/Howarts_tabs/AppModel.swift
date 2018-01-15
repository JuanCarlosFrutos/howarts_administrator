//
//  AppModel.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 29/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation
import UIKit

public class AppModel {
    
    var dictionaryAlumns = Dictionary<String, Alumn>()
    var houses = [House]()
    let mainBundle = Bundle.main
    let fileManager = FileManager.default
    private var NAME_OF_FILE_ALUMNS = ""
    private var NAME_OF_FILE_HOUSES = ""
    private var PATH_ALUMNS_BUNDLE: URL? = nil
    private var PATH_HOUSES_BUNDLE: URL? = nil
    private var PATH_ALUMNS_DOCUMENTS: URL? = nil
    private var PATH_HOUSES_DOCUMENTS: URL? = nil
    private var PATH_IMAGES_DOCUMENTS: URL? = nil
    
    init() {
        NAME_OF_FILE_ALUMNS = "data_alumns"
        NAME_OF_FILE_HOUSES = "data_houses"
        PATH_ALUMNS_BUNDLE = URL.init(string: "file:///" + mainBundle.bundlePath + "/data/" + NAME_OF_FILE_ALUMNS)!
        PATH_HOUSES_BUNDLE = URL.init(string: "file:///" + mainBundle.bundlePath + "/data/" + NAME_OF_FILE_HOUSES)!
        do{
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            PATH_ALUMNS_DOCUMENTS = documentDirectory.appendingPathComponent(NAME_OF_FILE_ALUMNS)
            PATH_HOUSES_DOCUMENTS = documentDirectory.appendingPathComponent(NAME_OF_FILE_HOUSES)
            PATH_IMAGES_DOCUMENTS = documentDirectory.appendingPathComponent("images")
            
        }
        catch let error{debugPrint(error.localizedDescription)}
        loadHouses()
        loadAlumns()
    }
    
    
    init(ArrayAlums: [Alumn], ArrayHouse: [House]) {
        ArrayAlums.forEach({self.dictionaryAlumns[$0.id] = $0})
        self.houses = ArrayHouse
    }
    
    func loadAlumns() {
        let jsonDecoder = JSONDecoder()
        var alumns_bundle = [Alumn]()
        var alumns_documents = [Alumn]()
        var allData: Data = Data.init()
        
        if fileManager.fileExists(atPath: PATH_ALUMNS_DOCUMENTS!.path) {
            do {
                allData = try String(contentsOf: PATH_ALUMNS_DOCUMENTS!, encoding: .utf8).data(using: .utf8)!
                alumns_documents = try jsonDecoder.decode([Alumn].self, from: allData)
            }
            catch let error{debugPrint(error.localizedDescription)}
            alumns_documents.forEach({
                self.dictionaryAlumns[$0.id] = $0
            })
            alumnsByHouse()
        } else {
            do{
                try fileManager.createDirectory(at: PATH_IMAGES_DOCUMENTS!, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error{debugPrint("Error guardando" + error.localizedDescription)}
            
            do {
                allData = try String(contentsOf: PATH_ALUMNS_BUNDLE!, encoding: .utf8).data(using: .utf8)!
                alumns_bundle = try jsonDecoder.decode([Alumn].self, from: allData)
            }
            catch let error{debugPrint(error.localizedDescription)}
            
            alumns_bundle.forEach({
                self.dictionaryAlumns[$0.id] = $0
                let pathImage = mainBundle.bundlePath + "/data/images/" + $0.image
                let image = UIImage(contentsOfFile:pathImage)
                saveImage(image: image!, name: $0.image)
            })
            //Save in documents default img too
            let image = UIImage(contentsOfFile:mainBundle.bundlePath + "/data/images/default.jpg")
            saveImage(image: image!, name: "default.jpg")
            alumnsByHouse()
        }

    }

    func loadHouses() {
        let jsonDecoder = JSONDecoder()
        var allData: Data = Data.init()
        
        if fileManager.fileExists(atPath: PATH_HOUSES_DOCUMENTS!.path) {
            do {
                allData = try String(contentsOf: PATH_HOUSES_DOCUMENTS!, encoding: .utf8).data(using: .utf8)!
                self.houses = try jsonDecoder.decode([House].self, from: allData)
            }
            catch let error{debugPrint(error.localizedDescription)}
        } else {
            do {
                allData = try String(contentsOf: PATH_HOUSES_BUNDLE!, encoding: .utf8).data(using: .utf8)!
                self.houses = try jsonDecoder.decode([House].self, from: allData)
            }
            catch let error{debugPrint(error.localizedDescription)}
        }
    }
    
    func saveAlumns() {
        let jsonEncoder = JSONEncoder()
        var data: Data = Data.init()
        var arrayAlumn = [Alumn]()
        for (_, alumn) in self.dictionaryAlumns {
            arrayAlumn.append(alumn)
        }
        do {
            // try "".write(to:self.PATH_HOUSES_DOCUMENTS!,atomically: true ,encoding: .utf8)
            data = try jsonEncoder.encode(arrayAlumn)
            try data.write(to: self.PATH_ALUMNS_DOCUMENTS!, options: [])
        }
        catch let error{debugPrint(error.localizedDescription)}
    }
    
    func alumnsByHouse() {
        self.houses.forEach({$0.alumns = []})
        for (id, alumn) in self.dictionaryAlumns {
            self.houses.forEach({
                if alumn.house == $0.name {
                    $0.alumns.append(id)
                }
            })
        }
    }
    
    func saveImage(image: UIImage, name:String) {
        
        let imageData = NSData(data: UIImagePNGRepresentation(image)!)
        let path = PATH_IMAGES_DOCUMENTS
        let fullPath = path!.appendingPathComponent(name)
        print(fullPath)
        imageData.write(to: fullPath, atomically: true)
        
    }
    
    func loadImage(name:String) -> UIImage? {
        let pathImage = PATH_IMAGES_DOCUMENTS?.appendingPathComponent(name)
        if let data = try? Data(contentsOf: pathImage!)
        {
            let image: UIImage = UIImage(data: data)!
            return image
        }
        return nil
    }
    
}

