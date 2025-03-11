//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Sanzhar Dauylov on 11.03.2025.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
    }

    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL
        
        var item: FeedItem {
            .init(id: id, description: description, location: location, imageURL: image)
        }
    }

    private static var OK_200: Int { return 200 }
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalideData
        }
        return try JSONDecoder().decode(Root.self, from: data).items.map { $0.item }
    }
}
