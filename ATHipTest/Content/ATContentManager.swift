/**
 @file  ATContentManager.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 This is the ContentManager, where the magic happend and we construct our ContenMessage
 
 */

import Foundation

class ATContentManager {
    // regexs
    static let mentionsRegex =      "(?<=\\@)((?:[\\w]+))"
    static let emoticonsRegex =     "(?<=\\()(\\S.{1,15}?)(?=\\))"
    // link detector
    static let urlsLookout =        NSTextCheckingResult.CheckingType.link.rawValue
    
    /**
     this function create the ContentMessage based on the string passed
        - parameter text: string passed in input
        - completion: returned ContentMessage
     */
    class func getContent(from text: String,  completion: @escaping ( (ContentMessage) -> Void) ) {
        
        var emoticonsArray : [String]?
        // regex matches emoticons
        if let emoticons =  ATRegexHelper.getMatches(in: text, for: emoticonsRegex) {
            emoticonsArray = emoticons
        }
        // regex matches mentions
        var mentionsArray : [String]?
        if let mentions =  ATRegexHelper.getMatches(in: text, for: mentionsRegex) {
            mentionsArray = mentions
        }
        // links using nsdatadetector
        ATDataDetectorHelper.getLink(for: text) { (links) in
            var linksArray : [Link]?
            if !links.isEmpty {
                linksArray = links
            }
            // we are done, return the ContentMessage
            let content = ContentMessage(emoticons: emoticonsArray, mentions: mentionsArray, links: linksArray)
            completion(content)
        }
        
    }
    

}

