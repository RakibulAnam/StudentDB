//
//  AddSubjectController.swift
//  StudentDB
//
//  Created by Jotno on 8/24/23.
//

import UIKit
import DropDown

class AddSubjectController: UIViewController {
    
    let subDrop = DropDown()
    let gradeDrop = DropDown()
    
    let sscSubList : [String] = ["Math", "Science", "Geography"]
    let hscSubList : [String] = ["Math", "Science", "Geography"]
    let gradeList : [String] = ["A+","A","B+", "B"]

    @IBOutlet weak var subjectDDView: UIView!
    
    @IBOutlet weak var gradeDDView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting up dropdown
        
        
        setDropDown(subDrop, dataSource: sscSubList, in: subjectDDView)
        setDropDown(gradeDrop, dataSource: gradeList, in: gradeDDView)
//        subDrop.anchorView = subjectDDView
//        subDrop.dataSource = subList
//        subDrop.bottomOffset = CGPoint(x: 0, y:(subDrop.anchorView?.plainView.bounds.height)!)
//        subDrop.topOffset = CGPoint(x: 0, y:-(subDrop.anchorView?.plainView.bounds.height)!)
        
        
        //Tap View
//        subjectDDView.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(customViewTapped2))
//        subjectDDView.addGestureRecognizer(tapGesture)
//
//
//        gradeDDView.isUserInteractionEnabled = true
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(customViewTapped2))
//        gradeDDView.addGestureRecognizer(tapGesture2)
        
        dropDowntapped(view: subjectDDView)
        dropDowntapped(view: gradeDDView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
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
        subDrop.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
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
