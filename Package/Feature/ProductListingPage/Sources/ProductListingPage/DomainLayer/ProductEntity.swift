//
//  ProductEntity.swift
//  ProductListingPage
//
//  Created by Chuon Anann on 03/05/2025.
//

public struct ProductEntity: Sendable {
    var product_id: Int?
    var product_name: String?
    var description: String?
    var price: Double?
    var image_url: ProductImageURLEntity?
    var c_brand: ProductBrandEntity?
    var is_productSet: Bool
    var is_special_brand: Bool
}

public struct ProductImageURLEntity: Sendable {
    var small: String?
    var large: String?
}

public struct ProductBrandEntity: Sendable {
    var id: String?
    var name: String?
}
