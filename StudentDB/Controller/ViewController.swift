//
//  ViewController.swift
//  StudentDB
//
//  Created by Jotno on 8/23/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var studentManager = StudentManager()
    
    var studentList : [StudentModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentManager.delegate = self
        tableView.dataSource = self
        studentManager.getStudents()
        //tableView.reloadData()
        
    }
    
    
    
}



extension ViewController: StudentManagerDelegate{
    func getData(_manager: StudentManager, studentData: [StudentModel]) {
        
        DispatchQueue.main.async {
            self.studentList = studentData
            self.tableView.reloadData()
        }
        
        
        
        
    }
    
}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        cell.textLabel?.text = studentList[indexPath.row].firstName
        
        return cell
        
    }
    
    
}
