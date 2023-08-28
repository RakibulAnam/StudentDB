//
//  SubjectManager.swift
//  StudentDB
//
//  Created by Jotno on 8/27/23.
//

import Foundation


protocol SubjectManagerDelegate{
    
    func getSSCSub(_ manager : SubjectManager, sscSub : [String])
    func getHSCSub(_ manager : SubjectManager, hscSub : [String])
    func getGrades(_ manager : SubjectManager, grades : [String])
    
    
}


struct SubjectManager{
    
    
    var delegate : SubjectManagerDelegate?
    
    func getSSCSubject(){
        if let url = URL(string: "http://localhost:9191/SSCSubjects"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    
                    //print(response)
                    //let dataString = String(data: safeData, encoding: .utf8)
                    
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode([String].self, from: safeData)
                        print(decodedData)
                        delegate?.getSSCSub(self, sscSub: decodedData)
                    }catch{
                        print(error)
                    }
                    
                    }
                        
                }
            
            task.resume()
            }
    }
    
    
    func getHSCSubject(){
        if let url = URL(string: "http://localhost:9191/HSCSubjects"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    
                    //print(response)
                    //let dataString = String(data: safeData, encoding: .utf8)
                    
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode([String].self, from: safeData)
                        delegate?.getHSCSub(self, hscSub: decodedData)
                    }catch{
                        print(error)
                    }
                    
                    }
                        
                }
            
            task.resume()
            }
    }
    
    
    func getGrades(){
        if let url = URL(string: "http://localhost:9191/Grades"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    
                    //print(response)
                    //let dataString = String(data: safeData, encoding: .utf8)
                    
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode([String].self, from: safeData)
                        delegate?.getGrades(self, grades: decodedData)
                    }catch{
                        print(error)
                    }
                    
                    }
                        
                }
            
            task.resume()
            }
    }
    
    
}


