/**
 @file  ContentMessage.swift
 
 - author: Leandro Ivan Candiotto
 - date: 11/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 Codable struct, easy to Encode and Decode thanks to Swift 4
 */

import UIKit

struct ContentMessage : Codable {
    let emoticons : [String]?
    let mentions : [String]?
    let links : [Link]?
}

struct Link : Codable {
    let url : String
    let title : String
}
