/**
 @file  ATRegexHelper.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 
 Utils for Regex:  https://regexr.com/ and https://www.raywenderlich.com/86205/nsregularexpression-swift-tutorial
 To note that in Swift, you need to use two backslashes, \\, for every backslash you use in a regular expression.
 The reason has to do with Swift having C-style string literals.
 
 mentions : "(?<=\\@)((?:[\\w]+))"
 (?<=\\@)                 # lookhaed from following char @ this will prevent to add the char to our result
 ((?:[\\w]+)             # regex the word following the @
 
 emoticons: "(?<=\\()(\\S.{1,15}?)(?=\\))"
 (?<=\\()                # lookhaed of (
 (\\S.{1,15}?)             # emoticon can only be from 1 to max 15 char as per specs and no space between ( and the word
 (?=\\))                 # lookbehind
 
 titleRegex = "<title\\b[^>]*>(.*?)</title>"
 <title\\b[^>]*>        # check title tag, to consider it can be <title> or <title id=...>
 (.*?)                  # group everything inside tag
 </title>               # until the tag clousure
 */

import Foundation

class ATRegexHelper {
    // title regex
    static let titleRegex =         "<title\\b[^>]*>(.*?)</title>"
    
    /**
     this function search the string and return and array of string that match the regex pattern
     - parameter string: string to search
     - parameter regex: regex pattern
     */
    class func getMatches(in string: String, for regex: String) -> [String]? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let result = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
            if result.count > 0 {
                return result.map { String(string[Range($0.range, in: string)!]) }
            } else {
                return nil
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
    
    /**
     this function search the string and return and array of string that match the title regex pattern
     - parameter string: string to search
     */
    class func getTitleMatch(text:String) -> [String] {
        var result : [String] = []
        let regex = try! NSRegularExpression(pattern: titleRegex, options: .caseInsensitive)
        let matches = regex.matches(in: text, options: [], range: NSRange(0..<text.utf16.count))
        for match in matches {
            let innerTextRange = match.range(at: 1)
            let innerText = (text as NSString).substring(with: innerTextRange)
            result.append(innerText)
        }
        return result
    }
    
}
