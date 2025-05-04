//
//  ApiService.swift
//  Networking
//
//  Created by Chuon Anann on 03/05/2025.
//

import Foundation

enum ApiEndPoint: String {
    case sephoraItems = "https://sephoraios.github.io/items.json"
}

public protocol ApiService {
    func fetchRemoteSephoraItems() async throws -> Data
}

public class ApiServiceImpl: ApiService {
    
    private let networkService: NetworkService
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func fetchRemoteSephoraItems() async throws -> Data {
        guard let url = URL(string: ApiEndPoint.sephoraItems.rawValue) else { throw URLError(.badURL) }
        return try await networkService.fetchData(from: url)
    }
    
}
