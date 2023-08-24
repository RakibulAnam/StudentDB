//
//  StudentManager.swift
//  StudentDB
//
//  Created by Jotno on 8/23/23.
//

import Foundation


protocol StudentManagerDelegate{
    
    func getData(_manager : StudentManager, studentData : [StudentModel])
    
}


struct StudentManager{
    
    
    var delegate : StudentManagerDelegate?
    
    
    func getStudents(){
        
        guard let url = URL(string: "http://localhost:9191/students") else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error{
                print("Error Starting sesseion \(error)")
                return
            }
            
            if let safeData = data {
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode([StudentModel].self, from: safeData)
                    print(decodedData)
                    delegate?.getData(_manager: self, studentData: decodedData)
                } catch  {
                    print(error)
                }
                
                
            }
        }
        
        task.resume()
        
        
    }
    
    
}
