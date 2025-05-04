//
//  Untitled 2.swift
//  ProductListingPage
//
//  Created by Chuon Anann on 03/05/2025.
//

import Networking
import Persistance
import Foundation

public protocol ProductListPageViewRepository {
    func fetchProductListPage() async throws -> [ProductEntity]
}

public class ProductListPageViewRepositoryImpl: ProductListPageViewRepository {
    
    private let apiService: ApiService
    private let memoryCacheService: MemoryCacheService

    public init(apiService: ApiService, memoryCacheService: MemoryCacheService) {
        self.apiService = apiService
        self.memoryCacheService = memoryCacheService
    }
    
    // If cache existe retrieve the cache, otherwise fetch frome remote
    public func fetchProductListPage() async throws -> [ProductEntity] {
        
        if let products: [ProductDTO] = memoryCacheService.getData(forKey: "productListPageEndPoint") {
            debugPrint("Data retrieved frome the cache")
            return products.map { $0.toEntity() }
        } else {
            debugPrint("Data fetch remotly")
            return try await fetchProductListPageFromRemote()
        }
    }
    
    // Fetch data remotely from WS
    func fetchProductListPageFromRemote() async throws -> [ProductEntity] {
        
        let jsonData = try await apiService.fetchRemoteSephoraItems()
        let products = try JSONDecoder().decode([ProductDTO].self, from: jsonData)
        
        // save in the cache when suceed
        memoryCacheService.setData(products, forKey: "productListPageEndPoint")
        debugPrint("Data saved in the cache")
        
        return products.map { $0.toEntity() }
    }
}
