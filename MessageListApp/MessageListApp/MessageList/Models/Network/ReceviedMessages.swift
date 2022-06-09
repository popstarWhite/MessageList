//
//  ReceviedMessages.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 03.06.2022.
//

import Foundation


struct ReceivedMessages {
    
    var receivedMessages: [String] = []
    
    init?(reciviedMessagesData: ReceivedMessagesData) {
        receivedMessages = reciviedMessagesData.result
    }
}
