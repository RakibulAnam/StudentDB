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
    
    let subList : [String] = ["Math", "Science", "Geography"]

    @IBOutlet weak var subjectDDView: UIView!
    
    @IBOutlet weak var gradeDDView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting up dropdown
        
        subDrop.anchorView = subjectDDView
        subDrop.dataSource = subList
        subDrop.bottomOffset = CGPoint(x: 0, y:(subDrop.anchorView?.plainView.bounds.height)!)
        subDrop.topOffset = CGPoint(x: 0, y:-(subDrop.anchorView?.plainView.bounds.height)!)
        
        
        //Tap View
        subjectDDView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(customViewTapped))
        subjectDDView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func customViewTapped(){
        subDrop.show()
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
