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
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        studentManager.getStudents()
        tableView.reloadData()
    }
    
    
    
}


//MARK: - StudentManager Delegate
extension StudentListController: StudentManagerDelegate{
    func getData(_manager: StudentManager, studentData: [StudentModel]) {
        
        DispatchQueue.main.async {
            self.studentList = studentData
            self.tableView.reloadData()
        }
        
        
        
        
    }
    
}

//MARK: - TableView DataSource Functions
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


//MARK: - TableView Delegate Functions
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
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        studentManager.deleteStudent(withID: studentList[indexPath.row].id)
        studentList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        tableView.endUpdates()
    }
        
        
    }
    


