/**
 @file  Extensions.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 */

import Foundation

extension String {
    // Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

extension URL {
    // Check if URL has http or https
    var isHTTPScheme: Bool {
        return scheme?.contains("http") == true || scheme?.contains("https") == true
    }
}


