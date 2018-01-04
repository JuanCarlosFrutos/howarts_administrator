//
//  HouseViewController.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 04/01/2018.
//  Copyright © 2018 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation
import UIKit

class HouseViewController: UIViewController {
    @IBOutlet weak var imageHouse: UIImageView!
    @IBOutlet weak var numberAlumns: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var h: ModelHouse
    var myImage = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberAlumns.text = "Number Students: 0"
        imageHouse.image = myImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        self.h = ad.h
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Put info in its fields
        self.name.text = h.house!.name
        self.numberAlumns.text = "Number Students: " + String(describing:h.house!.numberAlumns)
        self.imageHouse.image = myImage
    }
}
