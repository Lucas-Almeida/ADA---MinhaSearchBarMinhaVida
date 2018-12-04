//
//  ViewController.swift
//  MinhaSearchBarMinhaVida
//
//  Created by Lucas Pinheiro Almeida on 04/12/2018.
//  Copyright © 2018 Lucas Pinheiro Almeida. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    var clientData: [Client] = []
    var clientFilter: [Client] = []
    
    let context = CoreDataManager().persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
        
//        let cliente = Client(context: context)
//        cliente.name = "lucas"
//        cliente.fone = "9999-9999"
    
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
        self.clientData = try! context.fetch(fetchRequest)
        clientFilter = clientData
    }

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = filteredData[indexPath.row]
        
        cell.textLabel?.text = clientFilter[indexPath.row].name
        cell.detailTextLabel?.text = clientFilter[indexPath.row].fone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredData.count
        return clientFilter.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
        //            // If dataItem matches the searchText, return true to include it
        //            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        //        }

        
//        let fetchRequest: NSFetchRequest<Client> = Client.fetchRequest()
        
        let request = NSFetchRequest<Client>(entityName: Client.entity().managedObjectClassName)
        
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        request.predicate = predicate
        
        if searchText != "" {
            self.clientFilter = try! context.fetch(request)
        }
        
//        clientFilter = searchText.isEmpty ? clientData : clientData.filter { (cli: Client) -> Bool in
//            return cli.name?.range(of: searchText, options: .caseInsensitive) != nil
//        }
        
        tableView.reloadData()
    }
    
}
