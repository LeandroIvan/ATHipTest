/**
 @file  ATHipTestTests.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 */

import XCTest
@testable import ATHipTest

class ATHipTestTests: XCTestCase {
    
    var testCompleted: Bool = false
    var test_Expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getContent() {
        // string to test
        let testOne = "Hey @andy, (megusta) (coffee) are you free for lunch tomorrow?"
        let testTwo = "Good morning! (megusta) (coffee)"
        let testThree =  "Olympics are starting soon;http://www.nbcolympics.com"
        let testFour =  "@bob @john (hello) (areyoukiddingme) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        let testFive = "Hey @atlassian, this is my cool project! (thumbup) https://github.com/LeandroIvan/ATHipTest"
        let stringArray : [String] = [testOne, testTwo, testThree, testFour, testFive]
        
        test_Expectation = expectation(description: "test get content string")
        
        let randomIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
        let testString = stringArray[randomIndex]
        
        ATContentManager.getContent(from: testString) { (content) in
            let contentEncoded = ATJsonHelper.encodeContentMessage(content: content)
            var textToShow = "Result (\"\(testString)\") :\n"
            textToShow += String(describing: contentEncoded)
            print(textToShow)
            //            uncomment to perform decoding
            //            let contentDecoded = ATJsonHelper.decodeDataToContentMessage(json: contentEncoded)
            //            print(String(describing: contentDecoded))
            self.testCompleted = true
            self.test_Expectation?.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 15, handler: nil)
        XCTAssertTrue(testCompleted)
        
    }
    
}
