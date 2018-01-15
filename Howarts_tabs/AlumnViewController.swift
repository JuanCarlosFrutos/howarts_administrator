//
//  ViewController.swift
//  Hogwarts_administrator
//
//  Created by Juan Carlos Frutos Hernández on 16/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class AlumnViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var house: UIPickerView!
    
    var m: ModelAlumn
    var appModel: AppModel
    var alumn: Alumn
    var houseSelected = "Gryffindor"
    var imagePickerController: UIImagePickerController {
        let p  = UIImagePickerController()
        p.delegate = self
        return p
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
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
        self.name.text = alumn.name
        self.surname.text = alumn.surname
        self.image.image = m.image
        self.houseSelected = alumn.house
        for (index, element) in self.appModel.houses.enumerated() {
            if (element.name == alumn.house){
                self.house.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        activeCamera()
        tappedImage.image = appModel.loadImage(name: alumn.image)
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
        let alert = UIAlertController(title: "Save", message:"Sucess!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    //CAMERA
    
    func activeCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .front
            present(imagePickerController, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera", message:"Sorry, camera not found", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
        saveImage(image: image)
    }
    
    func saveImage(image: UIImage) {
        
        appModel.saveImage(image: image, name: self.alumn.name + ".jpg")
        alumn.image = self.alumn.name + ".jpg"
        
    }
}

