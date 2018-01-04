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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    var m:ModelAlumn
    var appModel:AppModel
    //I need a ordered array to show all students in table, so this is the solution.
    var arrayIterador: [String]
    var selectedId: String
    //var houses = [String](arrayLiteral: "Gryffindor","Hufflepuff","Ravenclaw","Slytherin")
    
    required init?(coder aDecoder: NSCoder) {
        //let ad  = UIApplication.sharedApplication().deletete as! AppDelegate
        let ad  = UIApplication.shared.delegate as! AppDelegate
        m = ad.m
        self.appModel = ad.appModel
        self.arrayIterador = Array(appModel.dictionaryAlumns.keys)
        self.selectedId = "empty"
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.setEditing(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //Charge model with info that i want to share with next view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        m.id = self.selectedId;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appModel.houses.count
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.appModel.dictionaryAlumns.count
        debugPrint(appModel.houses[section].numberAlumns)
        return appModel.houses[section].numberAlumns
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.appModel.houses[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath) as! MyCell
        let row = indexPath.row
        cell.name.text = self.appModel.dictionaryAlumns[self.appModel.houses[indexPath.section].alumns[row]]!.name
        cell.img.image = UIImage(contentsOfFile:"/Users/jcarlos/Documents/desarrollo/Hogwarts_administrator/images/maria.jpg" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedId = appModel.houses[indexPath.section].alumns[indexPath.row]
        //self.selectedId = appModel.dictionaryAlumns[self.arrayIterador[indexPath.row]]!.id
        performSegue(withIdentifier: "tableViewAlumnView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            appModel.dictionaryAlumns.removeValue(forKey: arrayIterador[row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item: String = arrayIterador[sourceIndexPath.row]
        arrayIterador.remove(at: sourceIndexPath.row)
        arrayIterador.insert(item, at: destinationIndexPath.row)
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            newButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            newButton.isEnabled = false
        }
    }
    @IBAction func newButton(_ sender: UIButton) {
        let newAlumn: Alumn? = Alumn.init()
        appModel.dictionaryAlumns[newAlumn!.id] = newAlumn
        self.selectedId = newAlumn!.id
        performSegue(withIdentifier:"tableViewAlumnView" , sender: nil)
    }
}

