//
//  ViewController.swift
//  Hogwarts_administrator
//
//  Created by Juan Carlos Frutos Hernández on 16/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class AlumnViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var house: UIPickerView!
    
    var m: ModelAlumn
    var appModel: AppModel
    var alumn: Alumn
    var myImage = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
    var houseSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Juan Carlos"
        surname.text = "Frutos"
        // house.text = "La mia"
        image.image = myImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        self.m = ad.m
        self.appModel = ad.appModel
        self.alumn = Alumn.init()
        super.init(coder: aDecoder)
        print("View controller inited")
    }
    
    //Charge in fields info recived by other view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Search info of user in appModel
        debugPrint("Im in detail view" + m.id)
        
        self.alumn = appModel.dictionaryAlumns[m.id]!
        //Put info in its fields
        self.name.text = alumn.name
        self.surname.text = alumn.surname
        //self.house. = alumn.house
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //Safe info in app model
        self.alumn.name = self.name.text!
        self.alumn.house = self.houseSelected
        self.alumn.surname = self.surname.text!
        //Update model
        appModel.dictionaryAlumns[m.id] = self.alumn
        appModel.saveAlumns()
        appModel.alumnsByHouse()
        //self.appModel.loadAlumns()
        //self.appModel.loadHouses()
        performSegue(withIdentifier: "saveSegueId", sender: nil)
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        self.appModel.dictionaryAlumns.removeValue(forKey: m.id )
    }
    
    //Picker Protocol
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appModel.houses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appModel.houses[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.houseSelected = self.appModel.houses[row].name
    }
    
    
}

