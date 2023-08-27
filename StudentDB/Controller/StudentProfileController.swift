//
//  StudentProfileController.swift
//  StudentDB
//
//  Created by Jotno on 8/27/23.
//

import UIKit

class StudentProfileController: UIViewController {
    
    
    
    @IBOutlet weak var sscTable: UITableView!
    
    @IBOutlet weak var sscHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hscTable: UITableView!
    
    @IBOutlet weak var hscHeightConstraint: NSLayoutConstraint!
    
    var studentModel : StudentModel?
    
    
    @IBOutlet weak var stdName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var board: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTableView()
        setProfile(studentModel)
        // Do any additional setup after loading the view.
    }
    
    
    
    private func addTableView(){
        //sscTable.delegate = self
        sscTable.dataSource = self
        //hscTable.delegate = self
        hscTable.dataSource = self
        
        sscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
        hscTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "subGrade")
    }
    
    override func viewWillLayoutSubviews() {
        sscHeightConstraint.constant = sscTable.contentSize.height
        hscHeightConstraint.constant = hscTable.contentSize.height
    }
    
    
    func setProfile(_ model : StudentModel?){
        if let model = model{
            var name = "\(model.firstName) \(model.lastName)"
            stdName.text = name
            email.text = model.email
            contact.text = model.contact
            dob.text = model.dob
            board.text = model.board
            address.text = model.address
        }
        
    }
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Setting Up the Views





//MARK: - DataSource Methods

extension StudentProfileController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if tableView == sscTable{
                    if let std = studentModel{
                        return std.ssc.count
                    }
                    
                } else if tableView == hscTable{
                    if let std = studentModel{
                        return std.hsc.count
                    }
                }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if tableView == sscTable{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "subGrade", for: indexPath) as! TableViewCell
            if let std = studentModel{
                cell.subName.text = std.ssc[indexPath.row].subject
                cell.grade.text = std.ssc[indexPath.row].gpa
            }
            return cell
        } else if tableView == hscTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "subGrade", for: indexPath) as! TableViewCell
            if let std = studentModel{
                cell.subName.text = std.hsc[indexPath.row].subject
                cell.grade.text = std.hsc[indexPath.row].gpa
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
