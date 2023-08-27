//
//  ViewController.swift
//  StudentDB
//
//  Created by Jotno on 8/23/23.
//

import UIKit

class StudentListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var studentManager = StudentManager()
    
    var studentList : [StudentModel] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        studentManager.getStudents()
        //tableView.reloadData()
        
    }
    
    
    
}



extension StudentListController: StudentManagerDelegate{
    func getData(_manager: StudentManager, studentData: [StudentModel]) {
        
        DispatchQueue.main.async {
            self.studentList = studentData
            self.tableView.reloadData()
        }
        
        
        
        
    }
    
}


extension StudentListController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        cell.textLabel?.text = studentList[indexPath.row].firstName
        
        return cell
        
    }
    
    
}

extension StudentListController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToProfile", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile"{
            let destinationVC = segue.destination as! StudentProfileController

            if let selectedIndex = tableView.indexPathForSelectedRow{
                
                let selectedStd = studentList[selectedIndex.row]
                
                destinationVC.studentModel = selectedStd
                
            }
            
            
        }
    }
        
        
    }
    


