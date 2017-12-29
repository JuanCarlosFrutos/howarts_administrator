//
//  ViewController.swift
//  Howarts_table
//
//  Created by Juan Carlos Frutos Hernández on 16/12/2017.
//  Copyright © 2017 Juan Carlos Frutos Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Bayern","BadenWürttemberg","Berlin","Brandenburg","Bremen","Hamburg","Hessen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nibs.
        tableView.delegate = self
        tableView.dataSource = self
        // tableView.tableFooterView = UIView(frame: CGRect)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel!.text = data[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController (title: "ROW SELECTED.", message: "\(data[indexPath.row])",preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(ac, animated:true, completion:nil)
        
    }


}

