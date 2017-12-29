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
    
    var m:Model_alumn
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
        //let ad  = UIApplication.sharedApplication().deletete as! AppDelegate
        m = ad.m
        
        super.init(coder: aDecoder)
        print("View controller inited")
    }
    
    //Charge in fields info recived by other view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        name.text = m.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

