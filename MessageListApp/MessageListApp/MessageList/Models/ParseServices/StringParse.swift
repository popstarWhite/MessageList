//
//  StringParse.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 04.06.2022.
//

import Foundation


final class StringParser {
 
    func parseFromFile(_ fileName: String, handler: ([String]?) -> Void) {
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: fileName, ofType: Constants.fileType)
        else {
            return
        }
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            let result: [String] = content.components(separatedBy: "\n").dropLast()
            handler(result)
        } catch {
            handler(nil)
        }
    }

    private enum Constants {
        static let fileType = "txt"
    }
}
