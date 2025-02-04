//
//  TestConstants.swift
//  MixpanelDemo
//
//  Created by Yarden Eitan on 6/28/16.
//  Copyright © 2016 Mixpanel. All rights reserved.
//

import Nocilla
import XCTest

@testable import Mixpanel

let kTestToken = "abc123"
let kDefaultServerString = "https://api.mixpanel.com"
let kDefaultServerTrackString = "https://api.mixpanel.com/track/"
let kDefaultServerEngageString = "https://api.mixpanel.com/engage/"
let kDefaultServerGroupsString = "https://api.mixpanel.com/groups/"
let kDefaultServerDecideString = "^https://api.mixpanel.com/decide(.*?)".regex

@discardableResult func stubEngage() -> LSStubRequestDSL {
    return stubRequest("POST", kDefaultServerEngageString as LSMatcheable).withHeader("Accept-Encoding", "gzip")!
}

@discardableResult func stubGroups() -> LSStubRequestDSL {
    return stubRequest("POST", kDefaultServerGroupsString as LSMatcheable?).withHeader("Accept-Encoding", "gzip")!
}

@discardableResult func stubTrack() -> LSStubRequestDSL {
    return stubRequest("POST", kDefaultServerTrackString as LSMatcheable).withHeader("Accept-Encoding", "gzip")!
}

@discardableResult func stubDecide() -> LSStubRequestDSL {
    return stubRequest("GET", kDefaultServerDecideString()).withHeader("Accept-Encoding", "gzip")!
}

extension XCTestCase {

    func XCTExpectAssert(_ expectedMessage: String, file: StaticString = #file, line: UInt = #line, block: () -> ()) {
        let exp = expectation(description: expectedMessage)

        Assertions.assertClosure = {
            (condition, message, file, line) in
            if !condition {
                exp.fulfill()
            }
        }

        // Call code.
        block()
        waitForExpectations(timeout: 60, handler: nil)
        Assertions.assertClosure = Assertions.swiftAssertClosure
    }

}
