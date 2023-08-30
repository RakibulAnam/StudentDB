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
    
    let studentManager = StudentManager()
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var boardTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var fromEdit : Bool?
    var id : Int?

    var firstName : String?
    var lastName : String?
    var email : String?
    var dob : String?
    var board : String?
    var contact : String?
    var address : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        emailTF.delegate = self
        contactTF.delegate = self
        dobTF.delegate = self
        submitButton.isEnabled = false
        if fromEdit == true{
            populateTF(firstName: firstName!, lastName: lastName!, email: email!, dob: dob!, board: board!, contact: contact!, address: address!)
        }
        
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
    
    
    
    @IBAction func addSSCPressed(_ sender: UIButton) {
    }
    
    @IBAction func addHSCPressed(_ sender: UIButton) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSSCSub" {
            
            if let destinationVC = segue.destination as? AddSubjectController{
                destinationVC.isSSC = true
            }
            
        }else if segue.identifier == "goToHSCSub"{
            
            if let destinationVC = segue.destination as? AddSubjectController{
                destinationVC.isSSC = false
            }
            
        }
    }
    
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        if fromEdit == true{
            updateStudent()
        } else {
            createStudent()
        }
        
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

//MARK: - TableView Delegate

extension AddStudentViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if tableView == sscTable{
            
            sscSub.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if tableView == hscTable{
          
            hscSub.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        }

        tableView.endUpdates()
    }
    
}



//MARK: - UITextField Delegate

extension AddStudentViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let input = textField.text ?? ""
        
        if textField == emailTF {
            if isValidEmail(input) {
            }else{
                submitButton.isEnabled = false
                textField.layer.borderColor = UIColor.red.cgColor
                shakeTextField(textField)
                textField.textColor = UIColor.red
                textField.text = "enter a valid email"
                
            }
        } else if textField == contactTF {
            if isValidContact(input) {
            }else{
                submitButton.isEnabled = false
                textField.layer.borderColor = UIColor.red.cgColor
                shakeTextField(textField)
                textField.textColor = UIColor.red
                textField.text = "contact must be of 11 numbers"
            } 
        } else if textField == dobTF{
            
            if isValidDob(input) {
            }else{
                submitButton.isEnabled = false
                textField.layer.borderColor = UIColor.red.cgColor
                shakeTextField(textField)
                textField.textColor = UIColor.red
                textField.text = "Date must be in format YYYY-MM-DD"
            }
        }
        
        validateTextFields()
        
    }
    
}



// Functions
extension AddStudentViewController{
    
    private func addTableView(){
        //sscTable.delegate = self
        sscTable.dataSource = self
        //hscTable.delegate = self
        hscTable.dataSource = self
        
        sscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
        hscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
    }
    
    
    
    func createStudent(){
        
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
    
    
    func updateStudent(){
        
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
        if let id = id{
            studentManager.updateStudent(add: std, withID: id)
        }
        
        
    }
    
    
    func addSubject(_ subject : Subject, isSSC : Bool){
        
        if isSSC == true {
            sscSub.append(subject)
        } else {
            hscSub.append(subject)
        }
        
        
      
        print("Function Called")
        sscTable.reloadData()
        hscTable.reloadData()
        print(sscSub)
        print(hscSub)
        
    }
    
    func populateTF( firstName : String, lastName : String, email : String, dob : String, board : String, contact : String, address : String){
        firstNameTF.text = firstName
        lastNameTF.text = lastName
        emailTF.text = email
        contactTF.text = contact
        boardTF.text = board
        addressTF.text = address
        dobTF.text = dob
    }
    
    
    func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidContact(_ contact: String) -> Bool{
        let contactRegex = "^[0-9]{11}$"

        let contactPred = NSPredicate(format:"SELF MATCHES %@", contactRegex)
        return contactPred.evaluate(with: contact)
    }
    
    func shakeTextField(_ textField: UITextField) {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(shakeAnimation, forKey: "position")
    }
    
    func isValidDob(_ dob: String) -> Bool{
        let dobRegex = #"^\d{4}-\d{2}-\d{2}$"#

        let dobPred = NSPredicate(format:"SELF MATCHES %@", dobRegex)
        return dobPred.evaluate(with: dob)
    }
    
    func validateTextFields() {
        let isTextField1Valid = isValidEmail(emailTF.text ?? "")
        let isTextField2Valid = isValidContact(contactTF.text ?? "")
        let isTextField3Valid = isValidDob(dobTF.text ?? "")

        if isTextField1Valid && isTextField2Valid && isTextField3Valid {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
}


