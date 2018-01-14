//
//  PopUp.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 14/01/2018.
//  Copyright © 2018 Juan Carlos Frutos Hernández. All rights reserved.
//

import Foundation
import UIKit

class PopUp: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Sorry, camera not found!"
    }
    
}
