/**
 @file  ATLinkHelper.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 Helper method that will asynchrously check the url and it will give me back a Link with url and the title if available
 
 */

import Foundation

public class ATLinkHelper {
    
    /**
     this function asynchrously get the html title from the website and return it as a Link
        - parameter urlString: string in input
        - parameter completion: Link in return when it's done
     */
    class func getWebsiteTitle(urlString : String,  completion: @escaping ((Link?) -> Void)){
        guard var url = URL(string: urlString) else{
            return
        }
        // NSDataDetector can recognise an URL even if it doesn't have http/s as prefix,
        // it's up to us have to create a correct URL if that is the case
        if !url.isHTTPScheme {
            url = URL(string: "https://" + urlString)!
        }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0 )
        // asych operation to get data from website
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            // errors/connection issues or data empty
            if error != nil || data == nil {
                let link = Link(url: urlString, title: "title not available")
                completion(link)
                return
            }
            
            // all good
            var link = Link(url: urlString, title: "title not available")
            if let contentString = String(data: data!, encoding: String.Encoding.utf8){
                var title = "title not available"
                // we have a string that define the html page, regex on the title tag
                let titles = ATRegexHelper.getTitleMatch(text: contentString)
                if titles.count > 0 {
                    title = titles.first!
                }
                link = Link(url: urlString, title: title)
            }
            completion(link)
       
        }.resume()
    }
}

