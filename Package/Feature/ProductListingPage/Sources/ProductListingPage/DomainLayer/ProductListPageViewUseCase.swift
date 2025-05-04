//
//  Untitled.swift
//  ProductListingPage
//
//  Created by Chuon Anann on 03/05/2025.
//

public protocol ProductListPageViewUseCase: Sendable {
    func execute() async throws -> [ProductEntity]
}

public final class ProductListPageViewUseCaseImpl: ProductListPageViewUseCase, @unchecked Sendable  {
    private let productListPageViewRepository: ProductListPageViewRepository
    
    public init(productListPageViewRepository: ProductListPageViewRepository) {
        self.productListPageViewRepository = productListPageViewRepository
    }
    
    public func execute() async throws -> [ProductEntity] {
        let products = try await productListPageViewRepository.fetchProductListPage()
        return orderProductsWithSpecialBrandFirstFrom(products: products)
    }
    
    // Separate sepcial product and put them first in the list, keep the order for the non special product
    func orderProductsWithSpecialBrandFirstFrom(products: [ProductEntity]) -> [ProductEntity] {
        let specialBrandProduct = products.filter{ $0.is_special_brand }
        let notSpecialBrandProduct = products.filter{ !$0.is_special_brand }
        return specialBrandProduct + notSpecialBrandProduct
    }
    
}
