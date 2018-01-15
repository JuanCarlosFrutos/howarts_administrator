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
    var selectedAlumn: ModelAlumn
    
    required init?(coder aDecoder: NSCoder) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        m = ad.m
        self.appModel = ad.appModel
        self.selectedAlumn = ModelAlumn()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ad  = UIApplication.shared.delegate as! AppDelegate
        m = ad.m
        self.appModel = ad.appModel
        tableView.reloadData()
        appModel.houses.forEach({debugPrint($0.alumns.count)})
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
        cell.img.image = appModel.loadImage(name: alumn.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlumn.id = appModel.houses[indexPath.section].alumns[indexPath.row]
        self.selectedAlumn.image = appModel.loadImage(name: appModel.dictionaryAlumns[selectedAlumn.id]!.image)
        performSegue(withIdentifier: "tableViewAlumnView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            appModel.dictionaryAlumns.removeValue(forKey: appModel.houses[indexPath.section].alumns[indexPath.row])
            appModel.houses[indexPath.section].alumns.remove(at: indexPath.row)
            appModel.saveAlumns()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
        let newAlumn: Alumn? = Alumn.init(house:"Gryffindor")
        appModel.dictionaryAlumns[newAlumn!.id] = newAlumn
        self.selectedAlumn.id = newAlumn!.id
        self.selectedAlumn.image = appModel.loadImage(name: appModel.dictionaryAlumns[self.selectedAlumn.id]!.image)
        performSegue(withIdentifier:"tableViewAlumnView" , sender: nil)
    }
}

