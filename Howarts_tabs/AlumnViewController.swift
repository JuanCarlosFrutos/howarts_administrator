//
//  ViewController.swift
//  Hogwarts_administrator
//
//  Created by Juan Carlos Frutos Hernández on 16/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class AlumnViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var house: UIPickerView!
    
    var m: ModelAlumn
    var appModel: AppModel
    var alumn: Alumn
    var myImage = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
    var houseSelected = ""
    var imagePickerController: UIImagePickerController {
        let p  = UIImagePickerController()
        p.delegate = self
        return p
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Default"
        surname.text = "Default"
        // house.text = "La mia"
        image.image = m.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        self.m = ad.m
        self.appModel = ad.appModel
        self.alumn = Alumn.init()
        super.init(coder: aDecoder)
    }
    
    //Charge in fields info recived by other view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.alumn = appModel.dictionaryAlumns[m.id]!
        //Put info in its fields
        self.name.text = alumn.name
        self.surname.text = alumn.surname
        self.image.image = m.image
        for (index, element) in self.appModel.houses.enumerated() {
            if (element.name == alumn.house){
                self.house.selectRow(index, inComponent: 0, animated: false)
            }
        }
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
        performSegue(withIdentifier: "saveSegueId", sender: nil)
    }
    /*
    @IBAction func deleteButton(_ sender: UIButton) {
        self.appModel.dictionaryAlumns.removeValue(forKey: m.id )
    }*/
    
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
    
    //CAMERA
    
    func activeCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .front
            present(imagePickerController, animated: true, completion: nil)
        }else{
            //show pop up
        }
    }
    
    //Save image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            //If something wrong. Hide camera
            dismiss(animated: true, completion: nil)
        }
        //Try to find image if it can't find it only return.
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        alumn.image = saveImage(image: image)
    }
    
    func saveImage(image: UIImage) -> String {
        
        let imageData = NSData(data: UIImagePNGRepresentation(image)!)
        let path = Bundle.main.bundleURL
        let uuid = self.alumn.id + ".png"
        let fullPath = path.appendingPathComponent(uuid)
        imageData.write(toFile: fullPath.absoluteString, atomically: true)
        return uuid
        
    }
    
    //pop up not camera
    func showPopup (_ sender: UIView) {
        let popUp = storyboard?.instantiateViewController(withIdentifier: "PopUp") as! PopUp
        
    }
    
    
}

