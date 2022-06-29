//
//  NetworkService.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation


struct NetworkService{
    
    static func GetPokedexInformation<T:Decodable>(url:String,objectDecode:T.Type,completion: @escaping (_ dictionary: Any, _ error: Error?) -> Void){
        
                var request = URLRequest(url: URL(string: url)!)
                request.cachePolicy = .reloadIgnoringLocalCacheData
                request.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: request) { data, response, error in

                    guard let dataResponse = data,error == nil else {
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, httpStatus.statusCode != 201{
                        // check for http errors
                        let otherCode = NSError(domain: "Internal Server Error", code: httpStatus.statusCode, userInfo: ["Network Error" : "We are not able to complete your request at the moment"])
                            completion([:], otherCode)
                    }else{
                        
                        do {
                            let farm = try JSONDecoder().decode(objectDecode, from: dataResponse)
                            DispatchQueue.main.async {
                                completion(farm, nil)
                            }
                            
                        } catch let parsingError {
                            DispatchQueue.main.async {
                                completion([:], parsingError)

                            }
                        }
                        
                        
                        
                    }
                }
                task.resume()

    }
    
    static func GetPokemonImage(url:String,completion: @escaping (_ file: Any, _ error: Error?) -> Void){
        
                var request = URLRequest(url: URL(string: url)!)
                request.cachePolicy = .reloadIgnoringLocalCacheData
                request.httpMethod = "GET"
                //request.timeoutInterval = .
                let task = URLSession.shared.dataTask(with: request) { data, response, error in

                    guard let dataResponse = data,error == nil else {
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, httpStatus.statusCode != 201{
                        // check for http errors
                        let otherCode = NSError(domain: "Internal Server Error", code: httpStatus.statusCode, userInfo: ["Network Error" : "We are not able to complete your request at the moment"])
                            completion([:], otherCode)
                    }else{
                        
                        do {
                            
                            completion(dataResponse, nil)
                            
                        } catch let parsingError {

                            completion([:], parsingError)
                        }
                        
                        
                        
                    }
                }
                task.resume()

    }
    
        
    
    static func
    ConvertToJsonData(dicData: [String:Any])->Data{
        
        var jsonData = Data()
        do{
            let jsonBody = try JSONSerialization.data(withJSONObject: dicData, options: .prettyPrinted)
            jsonData = jsonBody
            
        }catch{
            print("Error converting to json\(error.localizedDescription)")
        }
        
        return jsonData
    }
    
    static func cancelTaskWithUrl(_ url: URL) {
        URLSession.shared.getAllTasks { tasks in
          tasks
                .filter { $0.state == .running }
            .filter { $0.originalRequest?.url == url }.first?
            .cancel()
        }
      }
    
    static func completedSessions(_ url: URL){
        URLSession.shared.getAllTasks { tasks in
          tasks
                .filter { $0.state == .completed }
            .filter { $0.originalRequest?.url == url }.first?
            .cancel()
        }
        
        URLSession.shared.finishTasksAndInvalidate()
        print("finishTasksAndInvalidate")
    }
}
