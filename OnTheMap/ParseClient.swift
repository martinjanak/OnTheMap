//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Martin Janák on 27/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation
import MapKit

class ParseClient {
    
    static let shared = ParseClient()
    
    var session = URLSession.shared
    
    // MARK: GET
    
    func getStudentLocations(handler: @escaping ([StudentLocation]?) -> Void) {
        
        let url = URL(string: "\(Constants.baseUrl)/StudentLocation?limit=100&order=-updatedAt")!
        var request = URLRequest(url: url)
        
        request.addValue(Constants.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        sendRequest(request) { response in
            
            if let response = response,
                let students = response["results"] as? [[String: AnyObject]] {
                
                var studentLocations = [StudentLocation]()
                
                for student in students {
                    guard let studentLocation = StudentLocation(student) else { break }
                    studentLocations.append(studentLocation)
                }
                
                handler(studentLocations)
                
            } else {
                handler(nil)
            }
        }
    }
    
    // MARK: POST
    
    func postStudentLocation(user: User, mediaUrl: String, placemark: MKPlacemark, handler: @escaping ([String: AnyObject]?) -> Void) {
        
        let url = URL(string: "\(Constants.baseUrl)/StudentLocation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let httpBodyString = "{\"uniqueKey\": \"\(user.key)\", \"firstName\": \"\(user.firstName)\", \"lastName\": \"\(user.lastName)\",\"mapString\": \"\(placemark.name!)\", \"mediaURL\": \"\(mediaUrl)\",\"latitude\": \(placemark.coordinate.latitude), \"longitude\": \(placemark.coordinate.longitude)}"
        print("Http body string: \(httpBodyString)")
        request.httpBody = httpBodyString.data(using: String.Encoding.utf8)
        
        request.addValue(Constants.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        sendRequest(request) { response in
            DispatchQueue.main.async {
                handler(response)
            }
        }
    }
    
    // MARK: Helpers
    
    private func sendRequest(_ request: URLRequest, handler: @escaping ([String: AnyObject]?) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                handler(nil)
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode < 200 || statusCode > 299 {
                print("Error: status code: \(statusCode)")
                handler(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No data was returned")
                handler(nil)
                return
            }
            
            self.parseData(data, handler: handler)
        }
        
        task.resume()
    }
    
    private func parseData(_ data: Data, handler: ([String: AnyObject]?) -> Void) {
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
        } catch {
            print("ERROR: Could not parse the data as JSON: \(data)")
            handler(nil)
            return
        }
        handler(parsedResult)
    }
    
}
