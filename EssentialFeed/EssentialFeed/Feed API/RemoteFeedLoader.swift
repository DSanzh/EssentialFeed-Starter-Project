//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Sanzhar Dauylov on 27.02.2025.
//

import Foundation

public class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalideData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success(let data, let response):
                do {
                    let items = try FeedItemsMapper.map(data, response)
                    completion(.success(items))
                } catch {
                    completion(.failure(.invalideData))
                }
            case .failiure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let items = try FeedItemsMapper.map(data, response)
            return .success(items)
        } catch {
            return .failure(.invalideData)
        }
    }
}
