//
//  AddStudentViewController.swift
//  StudentDB
//
//  Created by Jotno on 8/24/23.
//

import UIKit

class AddStudentViewController: UIViewController {

    
    @IBOutlet weak var sscTable: UITableView!
    
    @IBOutlet weak var sscHeight: NSLayoutConstraint!
    
    @IBOutlet weak var hscTable: UITableView!
    
    @IBOutlet weak var hscHeight: NSLayoutConstraint!
    
    
    var sscSub : [Subject] = []
    var hscSub : [Subject] = []
    
    let addSubject = AddSubjectController()
    
    let studentManager = StudentManager()
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var boardTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubject.delegate = self
        addTableView()
        print(sscSub)
        sscTable.reloadData()
        hscTable.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print(sscSub)
    }
    

    override func viewWillLayoutSubviews() {
        sscHeight.constant = sscTable.contentSize.height
        hscHeight.constant = hscTable.contentSize.height
    }
    
    private func addTableView(){
        //sscTable.delegate = self
        sscTable.dataSource = self
        //hscTable.delegate = self
        hscTable.dataSource = self
        
        sscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
        hscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
    }
    
    
    
    func getStudentDetails(){
        
        let fName = firstNameTF.text
        let lName = lastNameTF.text
        let email = emailTF.text
        let contact = contactTF.text
        let board = boardTF.text
        let dob = dobTF.text
        let address = addressTF.text
        let sscSet = sscSub
        let hscSet = hscSub
        
        let std = AddStudentModel(firstName: fName!, lastName: lName!, email: email!, password: "123", dob: dob!, board: board!, contact: contact!, address: address!, ssc: sscSet, hsc: hscSet)
        
        if sscSet.count == 0 || hscSet.count == 0{
            print("No Subjects ")
            return
        }
        
        studentManager.postStudent(add: std)
        
    }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        getStudentDetails()
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}

//MARK: - Table DataSource
extension AddStudentViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sscTable{
            return sscSub.count
        } else if tableView == hscTable{
            return hscSub.count
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sscTable{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "subGrade", for: indexPath) as! TableViewCell
            cell.subName.text = sscSub[indexPath.row].subject
            cell.grade.text = sscSub[indexPath.row].gpa
            return cell
            
        } else if tableView == hscTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "subGrade", for: indexPath) as! TableViewCell
            cell.subName.text = hscSub[indexPath.row].subject
            cell.grade.text = hscSub[indexPath.row].gpa
            return cell
           
        }
        return UITableViewCell()
    }
    
    
    
    
    
}



extension AddStudentViewController : AddSubjectDelegate{
    func getSubject(_ controller: AddSubjectController, subjectData: Subject, isSSC: Bool) {
        if isSSC {
            sscSub.append(subjectData)
            print("SSC")
        } else {
            hscSub.append(subjectData)
            print("HSC")
        }
        sscTable.reloadData()
        hscTable.reloadData()
    }
    
    
}


