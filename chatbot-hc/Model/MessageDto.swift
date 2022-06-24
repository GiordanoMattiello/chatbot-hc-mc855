//
//  MessageModel.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 03/06/22.
//

import Foundation

class MessageDto {
    let messageText:String?
    let date:Date?
    let response:Bool?
    
    init(messageText: String?, date: Date?, response: Bool?) {
        self.messageText = messageText
        self.date = date
        self.response = response
    }
}
