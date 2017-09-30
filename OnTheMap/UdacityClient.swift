//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Martin Janák on 11/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation

class UdacityClient {
    
    static let shared = UdacityClient()
    
    // MARK: Properties
    
    var session = URLSession.shared
    var userId: String? = nil
    
    // MARK: GET
    
    func getUserData(handler: @escaping (User?) -> Void) {
        
        guard let userId = userId else {
            handler(nil)
            return
        }
        
        let url = URL(string: "\(Constants.baseUrl)/users/\(userId)")!
        let request = URLRequest(url: url)
        
        sendRequest(request) { response in
            if let response = response,
                let user = response["user"] as? [String: AnyObject],
                let firstName = user["first_name"] as? String,
                let lastName = user["last_name"] as? String,
                let key = user["key"] as? String {
                
                let user = User(key: key, firstName: firstName, lastName: lastName)
                handler(user)
                
            } else {
                handler(nil)
            }
        }
    }
    
    // MARK: POST
    
    func postSession(username: String, password: String, handler: @escaping (Bool) -> Void) {
    
        let url = URL(string: "\(Constants.baseUrl)/session")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        sendRequest(request) { response in
            
            if let account = response?["account"] as? [String: AnyObject],
                let userId = account["key"] as? String {
                self.userId = userId
                DispatchQueue.main.async {
                    handler(true)
                }
            } else {
                DispatchQueue.main.async {
                    handler(false)
                }
            }
        }
    }
    
    // MARK: DELETE
    
    func deleteSession(handler: @escaping ([String: AnyObject]?) -> Void) {
        
        let url = URL(string: "\(Constants.baseUrl)/session")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
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
        
        // Udacity security feature
        let range = Range(5..<data.count)
        let newData = data.subdata(in: range)
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String: AnyObject]
        } catch {
            print("ERROR: Could not parse the data as JSON: \(data)")
            handler(nil)
            return
        }
        handler(parsedResult)
    }
    
}
