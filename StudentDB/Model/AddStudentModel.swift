//
//  AddStudentModel.swift
//  StudentDB
//
//  Created by Jotno on 8/27/23.
//

import Foundation


struct AddStudentModel : Codable{
    
    var firstName : String
    var lastName : String
    var email : String
    var password : String
    var dob : String
    var board : String
    var contact : String
    var address : String
    var ssc : [Subject]
    var hsc : [Subject]
    
}


