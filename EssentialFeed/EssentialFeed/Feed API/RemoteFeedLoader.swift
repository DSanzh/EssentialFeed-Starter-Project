//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Sanzhar Dauylov on 27.02.2025.
//

import Foundation

public class RemoteFeedLoader: FeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalideData
    }
    
    public typealias Result = LoadFeedResult<Error>
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data, let response):
                completion(FeedItemsMapper.map(data, response))
            case .failiure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
