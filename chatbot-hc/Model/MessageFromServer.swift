//
//  MessageFromServer.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 01/07/22.
//

import Foundation


class MessageFromServer: Codable{
    let assistant_message:String?
    let client_message:String?

    init(assistant_message: String?, client_message: String?) {
        self.assistant_message = assistant_message
        self.client_message = client_message
    }
    func toMessageDTO() ->MessageDto {
        return MessageDto(messageText: assistant_message, date: .now, response: true)
    }
}
