//
//  TableViewController.swift
//  JsonToCoreData_03
//
//  Created by QTS Coder on 7/19/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var myPerson = Array<NSManagedObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteAllData()
        convertJson(link: "https://api.myjson.com/bins/1f6wpr")
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(myPerson.count)

    }
    
    func deleteAllData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let rq = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let rqBatch = NSBatchDeleteRequest(fetchRequest: rq)
        do {
            try context.execute(rqBatch)
            try context.save()
            tableView.reloadData()
        } catch  {
            
        }
        
    }
    
    func loadData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let rq = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            myPerson =  try context.fetch(rq) as! [NSManagedObject]
        } catch {
            
        }
    }
    
    func saveData(id: Int, first_name: String, last_name: String, email: String, gender: String, ip_address:String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        let user = NSManagedObject(entity: entity!, insertInto: context)
        
        user.setValue(id, forKey: "id")
        user.setValue(first_name, forKey: "first_name")
        user.setValue(last_name, forKey: "last_name")
        user.setValue(email, forKey: "email")
        user.setValue(gender, forKey: "gender")
        user.setValue(ip_address, forKey: "ip_address")
        
        
        do {
            try context.save()
            self.myPerson.append(user)
        } catch  {
            
        }
        
    }
    
    func convertJson(link:String){
        
        let url = URL(string: link)
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            if error != nil{
                print(error!)
            } else
            {
                if let content = data {
                    do{
                        let myData = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as! Array<[String: AnyObject]>
                        
                        for i in 0...myData.count-1{
                            
                            let id = myData[i]["id"] as! Int
                            let first_name = myData[i]["first_name"] as! String
                            let last_name = myData[i]["last_name"] as! String
                            let email = myData[i]["email"] as! String
                            let gender = myData[i]["gender"] as! String
                            let ip_address = myData[i]["ip_address"] as! String
                            
                            self.saveData(id: id, first_name: first_name, last_name: last_name, email: email, gender: gender, ip_address: ip_address)
                            
                        }
                        
                        self.tableView.reloadData()
                        
                    }catch{
                        
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myPerson.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let user = myPerson[indexPath.row]
        let firstname = user.value(forKey: "first_name") as? String
        let lastname = user.value(forKey: "last_name") as? String
        
        let fullname = firstname! + " " + lastname!
        
        cell.lblid.text = String(describing: user.value(forKey: "id")!)
        cell.lblemail.text = user.value(forKey: "email") as? String
        cell.lblgender.text = user.value(forKey: "gender") as? String
        cell.lblip.text = user.value(forKey: "ip_address") as? String
        cell.lblfullname.text = fullname
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(myPerson[indexPath.row])
    }
    
}
