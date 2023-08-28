//
//  AddSubjectController.swift
//  StudentDB
//
//  Created by Jotno on 8/24/23.
//

import UIKit
import DropDown


protocol AddSubjectDelegate{
    func getSubject(_ controller: AddSubjectController, subjectData : Subject, isSSC : Bool)
}


class AddSubjectController: UIViewController {
    
    
    var subjectManager = SubjectManager()
    var delegate : AddSubjectDelegate?
    let subDrop = DropDown()
    let gradeDrop = DropDown()
    
    var subject : String?
    var grade : String?
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    var fromButton : String?
    
    var sscSubList : [String] = ["Math", "Science", "Geography"]
    var hscSubList : [String] = ["Math", "Science", "Geography"]
    var gradeList : [String] = ["A+","A","B+", "B"]

    @IBOutlet weak var subjectDDView: UIView!
    
    @IBOutlet weak var gradeDDView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectManager.delegate = self
        subjectManager.getSSCSubject()
        subjectManager.getHSCSubject()
        subjectManager.getGrades()
        fromButton = "HSC"
        dropDowntapped(view: subjectDDView)
        dropDowntapped(view: gradeDDView)
    
    }
    
    
    @IBAction func addSubjectPressed(_ sender: Any) {
        
        if let selectedSub = sendObject(){
            if fromButton == "SSC"{
                delegate?.getSubject(self, subjectData: selectedSub, isSSC: true)
            }else if fromButton == "HSC"{
                delegate?.getSubject(self, subjectData: selectedSub, isSSC: false)
            }
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    

    
    
    

    


}


extension AddSubjectController : SubjectManagerDelegate{
    func getSSCSub(_ manager: SubjectManager, sscSub: [String]) {
        sscSubList = sscSub
        
        DispatchQueue.main.async {
            
            if(self.fromButton == "SSC"){
                self.setDropDown(self.subDrop, dataSource: self.sscSubList, in: self.subjectDDView)
            }else {
                self.setDropDown(self.subDrop, dataSource: self.hscSubList, in: self.subjectDDView)
            }
            
            self.setDropDown(self.gradeDrop, dataSource: self.gradeList, in: self.gradeDDView)
        }
        
    }
    
    func getHSCSub(_ manager: SubjectManager, hscSub: [String]) {
        hscSubList = hscSub
    }
    
    func getGrades(_ manager: SubjectManager, grades: [String]) {
        gradeList = grades
    }
    
    
}

//MARK: - Setting Up Functions to Use

extension AddSubjectController{
    
    
    
    func dropDowntapped(view : UIView){
        if view == subjectDDView{
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(subjectViewTapped))
            view.addGestureRecognizer(tapGesture)
        } else if view == gradeDDView {
            view.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gradeViewTapped))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @objc func gradeViewTapped(){
        gradeDrop.show()
    }
    @objc func subjectViewTapped(){
        subDrop.show()
    }
    
    func setDropDown(_ dropDown : DropDown, dataSource : [String], in view : UIView){
        dropDown.anchorView = view
        dropDown.dataSource = dataSource
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        
        
        if dropDown == subDrop {
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                subLabel.text = item
                subject = item
            }
            
        }else if dropDown == gradeDrop {
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                gradeLabel.text = item
                grade = item
            }
        }
    }
    
    
    func sendObject() -> Subject? {
       
        if let subject = subject, let grade = grade{
            let sub  = Subject(subject: subject, gpa: grade)
            return sub
        }
        return nil
    }
    
}



