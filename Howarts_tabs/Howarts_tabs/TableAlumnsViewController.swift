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
    var selectedAlumn: ModelAlumn
    let mainBundle = Bundle.main
    
    required init?(coder aDecoder: NSCoder) {
        //let ad  = UIApplication.sharedApplication().deletete as! AppDelegate
        let ad  = UIApplication.shared.delegate as! AppDelegate
        m = ad.m
        self.appModel = ad.appModel
        self.arrayIterador = Array(appModel.dictionaryAlumns.keys)
        self.selectedAlumn = ModelAlumn()
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
        m.id = self.selectedAlumn.id;
        m.image = self.selectedAlumn.image;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appModel.houses.count
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.appModel.dictionaryAlumns.count
        // debugPrint(appModel.houses[section].numberAlumns)
        return appModel.houses[section].alumns.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.appModel.houses[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath) as! MyCell
        let row = indexPath.row
        let alumn = self.appModel.dictionaryAlumns[self.appModel.houses[indexPath.section].alumns[row]]!
        cell.name.text = alumn.name
        let pathImage = mainBundle.bundlePath + "/" + alumn.image
        cell.img.image = UIImage(contentsOfFile:pathImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlumn.id = appModel.houses[indexPath.section].alumns[indexPath.row]
        debugPrint(selectedAlumn.id)
        let pathImage = mainBundle.bundlePath + "/" + appModel.dictionaryAlumns[self.selectedAlumn.id]!.image
        self.selectedAlumn.image = UIImage(contentsOfFile:pathImage)
        performSegue(withIdentifier: "tableViewAlumnView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            appModel.dictionaryAlumns.removeValue(forKey: arrayIterador[row])
            appModel.houses[indexPath.section].alumns.remove(at: indexPath.row)
            self.arrayIterador = Array(appModel.dictionaryAlumns.keys)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    /*func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }*/
    
    /*func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item: String = arrayIterador[sourceIndexPath.row]
        arrayIterador.remove(at: sourceIndexPath.row)
        arrayIterador.insert(item, at: destinationIndexPath.row)
    }*/

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
        self.selectedAlumn.id = newAlumn!.id
        performSegue(withIdentifier:"tableViewAlumnView" , sender: nil)
    }
}

