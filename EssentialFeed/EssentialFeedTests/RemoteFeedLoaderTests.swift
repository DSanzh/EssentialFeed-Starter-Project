//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Sanzhar Dauylov on 27.02.2025.
//

import XCTest
import EssentialFeed

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDateFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }
    
    private func makeSUT(url: URL = URL(string: "https://example.com/feed.xml")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

}
