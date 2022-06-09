//
//  NetworkMessagesManager.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 03.06.2022.
//

import Foundation


struct NetworkMessagesManager {
    
    func fetchReceviedMessage(completionHandler: @escaping (ReceivedMessages) -> Void) {
        let urlString = "https://numero-logy-app.org.in/getMessages?offset=0"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let receivedMessages = self.parseJSON(withData: data) {
                    completionHandler(receivedMessages)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> ReceivedMessages? {
        let decoder = JSONDecoder()
        
        do {
            let receivedMessagesData = try decoder.decode(ReceivedMessagesData.self, from: data)
            guard let receivedMessages = ReceivedMessages(reciviedMessagesData: receivedMessagesData) else {
                return nil
            }
            return receivedMessages
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
