//
//  NetworkServices.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

protocol NetworkActions {
    func fetchBrastlewark(_ msisdn: String, completion callback: @escaping(_ result: Bool, _ description: BrastlewarkResponse?) -> Void )
}

public class NetworkServices {
    
    static let shared = NetworkServices()
    
    func getStringDictionary(_ parametersDictionary: Dictionary<String, String>, format: String, separator: String)
        -> String {
        let orderParameters =
            parametersDictionary.sorted( by: { (string1: (String, String), string2: (String, String)) -> Bool in
            string1.0 < string2.0 })
        var parameters = ""
        for (code, value) in orderParameters {
            if parameters.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                parameters += separator//", "
            }
            let verifValue = value.lengthOfBytes(using: String.Encoding.utf8) == 0 || value == "nil" ? "" : value
            parameters +=
                format.replacingOccurrences(of: "code", with: code).replacingOccurrences(of: "value", with: verifValue)
        }
        return parameters
    }
    
    func doRequest(_ urlRequest: URLRequest, parameters data: Data?, completion callback: @escaping(_ result: Bool, _ description: String)
    -> Void ) {
        let method = urlRequest.httpMethod!
        if method == "POST" {
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (data, response, error) in
                if let _ = error {
                    callback(false, "")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                    else {
                        callback(false, "")
                        return
                    }
                if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                    let data = data,
                    let _ = String(data: data, encoding: .utf8) {
                } else if let
                    mimeType = httpResponse.mimeType, (mimeType == "application/json") || (mimeType == "text/plain" ),
                    let data = data, let string = String(data: data, encoding: .utf8) {
                    callback(true, string)
                }
            }
            task.resume()
        } else {
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let _ = error {
                    callback(false, "")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
                    else {
                        callback(false, "")
                        return
                    }
                if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                    let data = data,
                    let string = String(data: data, encoding: .utf8) {
                } else if let
                    mimeType = httpResponse.mimeType, (mimeType == "application/json") || (mimeType == "text/plain" ),
                    let data = data, let string = String(data: data, encoding: .utf8) {
                    callback(true, string)
                }
            }
            task.resume()
        }
        
    }
    
}

extension NetworkServices: NetworkActions {
    
    func fetchBrastlewark(_ msisdn: String, completion callback: @escaping(_ result: Bool, _ description: BrastlewarkResponse?) -> Void ) {
        /*let parameters = [
            "msisdn": "",
            "deviceId": "token_Id",
            "flagSession": ""
        ]*/
        let parametersString = ""//self.getStringDictionary(parameters, format: "code=value", separator: "&")
        
        let theurl = URL(string: NetworkConstants.gnomesURL)
        var urlRequest = URLRequest(url: theurl!)
//        urlRequest.httpBody = parametersString.data(using: String.Encoding.utf8)
        urlRequest.httpMethod = "GET"

        if let data = parametersString.data(using: String.Encoding.utf8) {
            self.doRequest(urlRequest, parameters: data) { success , response in
                if let response = BrastlewarkResponse(JSONString: response) {
                    callback(true, response)
                } else {
                    callback(false, nil)
                }
            }
        }
    }
    
}
