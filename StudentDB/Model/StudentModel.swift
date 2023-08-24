//
//  StudentModel.swift
//  StudentDB
//
//  Created by Jotno on 8/23/23.
//

import Foundation


struct StudentModel : Codable{
 
    var id : Int
    var firstName : String
    var lastName : String
    var email : String
    //var password : String
    var dob : String
    var board : String
    var contact : String
    var address : String
    var ssc : [Subject]
    var hsc : [Subject]
}

struct Subject : Codable{
    
    var subject : String
    var gpa : String
    
    
}
