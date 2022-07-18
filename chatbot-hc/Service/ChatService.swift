//
//  ChatService.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 03/06/22.
//

import Foundation
enum ApiError: Error {
    case noResponse
}
class ChatService {
    static let shared = ChatService()
    
    func getMessage(question: String ,completion: @escaping (MessageFromServer)-> Void) {
        let json: [String: Any] = ["message": "\(question)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "http://127.0.0.1:5000/request_answer") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8",forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8",forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, resp, error in
            do{
                guard let data = data else { throw ApiError.noResponse }
                let message = try JSONDecoder().decode(MessageFromServer.self, from: data)
                print("Call to API sucess")
                DispatchQueue.main.async{
                    completion(message)
                }
            }catch let error{
                print("Call to API fail",error)
            }
        }
        .resume()
    }
    
    
    
}
