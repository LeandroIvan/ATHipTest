/**
 @file  ATJsonHelper.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 Encode and Decode made easy by Swift 4
 
  */

import Foundation

class ATJsonHelper {
    
    class func encodeContentMessage(content: ContentMessage?) -> Any {
        guard let content = content else {
            return ""
        }
        do {
            //Convert JSON back to Data
            let encoder = JSONEncoder()
            let encodedData = try? encoder.encode(content)
            if let json = try? JSONSerialization.jsonObject(with: encodedData!, options: .allowFragments) {
                let json =  json 
                return json
            }
        }
        return ""
    }
    
    class func decodeDataToContentMessage(json: Any?) -> ContentMessage? {
        do {
            //Convert JSON back to Data
            var jsonData: Data?
            var decodedContent: ContentMessage?
            
            if let json = json {
                jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
                //Convert JSON Data back to ContentMessage Struct
                if let data = jsonData {
                    decodedContent = try? JSONDecoder().decode(ContentMessage.self, from: data)
                    return decodedContent
                }
            }
            
        }
        return nil
    }
}
