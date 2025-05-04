//
//  Untitled 3.swift
//  ProductListingPage
//
//  Created by Chuon Anann on 03/05/2025.
//

public struct ProductDTO: Codable {
    var product_id: Int?
    var product_name: String?
    var description: String?
    var price: Double?
    var image_url: ProductImageURL?
    var c_brand: ProductBrand?
    var is_productSet: Bool
    var is_special_brand: Bool
    
    func toEntity() -> ProductEntity {
        return ProductEntity(product_id: product_id, product_name: product_name, description: description, price: price, image_url: image_url?.toEntity(), c_brand: c_brand?.toEntity(), is_productSet: is_productSet, is_special_brand: is_special_brand)
    }
}

public struct ProductImageURL: Codable {
    var small: String?
    var large: String?
    func toEntity() -> ProductImageURLEntity {
        return ProductImageURLEntity(small: small, large: large)
    }
}

public struct ProductBrand: Codable {
    var id: String?
    var name: String?
    
    func toEntity() -> ProductBrandEntity {
        return ProductBrandEntity(id: id, name: name)
    }
}
