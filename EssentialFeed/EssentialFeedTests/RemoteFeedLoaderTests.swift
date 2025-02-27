//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sanzhar Dauylov on 27.02.2025.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init() {
        let client = HTTPClient()
        let sut = RemoteFeedLoader()
        
        XCTAssert(client.requestedURL)
    }

}
