//
//  ViewController.swift
//  Hogwarts_administrator
//
//  Created by Juan Carlos Frutos Hernández on 16/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class AlumnViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var house: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var m: ModelAlumn
    var appModel: AppModel
    var alumn: Alumn
    var myImage = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Juan Carlos"
        surname.text = "Frutos"
        house.text = "La mia"
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
        self.house.text = alumn.house
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //Safe info in app model
        self.alumn.name = self.name.text!
        self.alumn.house = self.house.text!
        self.alumn.surname = self.surname.text!
        //Update model
        appModel.dictionaryAlumns[m.id] = self.alumn
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        self.appModel.dictionaryAlumns.removeValue(forKey: m.id )
    }
}

