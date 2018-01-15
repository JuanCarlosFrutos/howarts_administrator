//
//  TableHousesViewController.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 28/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class TableHousesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var appModel: AppModel
    var h: ModelHouse
    var selectedHouse: ModelHouse
    let mainBundle = Bundle.main
    
    required init?(coder aDecoder: NSCoder) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        h = ad.h
        self.appModel = ad.appModel
        self.selectedHouse = ModelHouse()
        self.selectedHouse.house = appModel.houses[0]
        self.selectedHouse.img = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        h.house = self.selectedHouse.house;
        h.img = self.selectedHouse.img;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appModel.houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseCell
        let row = indexPath.row
        let pathImage = mainBundle.bundlePath + "/data/images/" + appModel.houses[row].image
        cell.imageHouse.image = UIImage(contentsOfFile:pathImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedHouse.house = appModel.houses[indexPath.row]
        let pathImage = mainBundle.bundlePath + "/data/images/" + appModel.houses[indexPath.row].image
        selectedHouse.img = UIImage(contentsOfFile:pathImage)
        performSegue(withIdentifier: "listHouseDetailHouse", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
}

