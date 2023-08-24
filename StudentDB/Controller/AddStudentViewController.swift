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
    
    
    var sscSub : [String] = []
    var hscSub : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTableView()
        // Do any additional setup after loading the view.
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addSub", sender: self)
    }
    
    

}

extension AddStudentViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == sscTable{
//            return sscSub.count
//        } else if tableView == hscTable{
//            return hscSub.count
//        }
//        else {return 0}
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subGrade", for: indexPath) as! TableViewCell
        cell.subName.text = "Subject"
        return cell
    }
    
    
    
    
    
}
