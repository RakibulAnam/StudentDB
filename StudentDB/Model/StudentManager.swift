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
        
        guard let url = URL(string: K.API.GET) else {
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
    
    
    func postStudent(add std : AddStudentModel){
        
        guard let url = URL(string: K.API.POST) else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jSONData = std
        
        let encoder = JSONEncoder()
        
        if let encodedData = try? encoder.encode(jSONData){
            
            print(String(data: encodedData, encoding: .utf8)!)
            request.httpBody = encodedData
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                                print("ErrorBro: \(error.localizedDescription)")
                                return
                            }
                
                if let data = data {
                             do {
                                 // Parse the response data if needed
                                 let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                                 print(jsonResponse)
                             } catch {
                                 print("JSON Error: \(error.localizedDescription)")
                             }
                }
                
            }.resume()
            
        }
        
        
        
        //END
    }
    
    
}
