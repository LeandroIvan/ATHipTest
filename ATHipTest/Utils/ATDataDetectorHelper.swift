/**
 @file  ATDataDetectorHelper.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 Our NSDataDetector, it get a string and give us back the Link with title (if available) and the url
 
 */

import Foundation

class ATDataDetectorHelper {
    static let urlsLookout =        NSTextCheckingResult.CheckingType.link.rawValue
    
    /**
     this function find the link inside the string and return an array of Link object
     - parameter string: string in input
     - parameter OnCompletion: Link object with url and title.
     */
    class func getLink(for string: String,  completion: @escaping (([Link]) -> Void)){
        var links : [Link] = []
        let detector = try! NSDataDetector(types: urlsLookout)
        let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        if matches.isEmpty {
            completion(links)
        }
        
        for match in matches {
            guard let range = Range(match.range, in: string) else { continue }
            let urlString = String(string[range])
            ATLinkHelper.getWebsiteTitle(urlString: urlString, completion: { (link) in
                guard let link = link else {
                    completion(links)
                    return
                }
                links.append(link)
                while links.count == matches.count {
                    completion(links)
                    return
                }
            })
        }
    }
    
}
