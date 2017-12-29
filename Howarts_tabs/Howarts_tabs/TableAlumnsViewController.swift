//
//  TableAlumnsViewController.swift
//  Howarts_tabs
//
//  Created by Juan Carlos Frutos Hernández on 28/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class TableAlumnsViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var m:ModelAlumn
    var appModel:AppModel
    //I need a ordered array to show all students in table, so this is the solution.
    var arrayIterador: [String]
    var selectedId: String
    
    let data = ["Bayern","BadenWürttemberg","Berlin","Brandenburg","Bremen","Hamburg","Hessen"]
    
    required init?(coder aDecoder: NSCoder) {
        //let ad  = UIApplication.sharedApplication().deletete as! AppDelegate
        let ad  = UIApplication.shared.delegate as! AppDelegate
        m = ad.m
        //self.appModel = AppModel.init(ArrayAlums: [Alumn.init(), Alumn.init(), Alumn.init()], ArrayHouse: [House.init(), House.init()])
        self.appModel = ad.appModel
        self.arrayIterador = Array(appModel.dictionaryAlumns.keys)
        self.selectedId = "empty"
        super.init(coder: aDecoder)
        // print("View controller inited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.tableFooterView = UIView(frame: CGRect)
    }
    
    //Charge model with info that i want to share with next view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("Update mini-model")
        m.id = self.selectedId;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayIterador.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel!.text = self.appModel.dictionaryAlumns[arrayIterador[row]]!.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Row selected")
        self.selectedId = appModel.dictionaryAlumns[self.arrayIterador[indexPath.row]]!.id
        performSegue(withIdentifier: "tableViewAlumnView", sender: nil)
        // let ac = UIAlertController (title: "ROW SELECTED.", message: "\(data[indexPath.row])",preferredStyle: .alert)
        // ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        // present(ac, animated:true, completion:nil)

    }


}

