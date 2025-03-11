//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Sanzhar Dauylov on 11.03.2025.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failiure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
