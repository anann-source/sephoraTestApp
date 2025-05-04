import XCTest
@testable import ProductListingPage
@testable import Persistance
@testable import Networking

/* Mocks */
class MockAPI: ApiService {
    func fetchRemoteSephoraItems() async throws -> Data {
        return Data() // Simule un JSON vide ou invalide
    }
}

class MockRepo: ProductListPageViewRepository {
    private let productFectch: [ProductEntity]
    init(productFectch: [ProductEntity]) { self.productFectch = productFectch }
    func fetchProductListPage() async throws -> [ProductEntity] { productFectch }
}

class MockMemoryCacheService: MemoryCacheService {
    private let stored: [ProductDTO]?
    init(data: [ProductDTO]?) { self.stored = data }

    func getData<T>(forKey: String) -> T? {
        return stored as? T
    }

    func setData<T>(_ data: T, forKey: String) {}
}

/* Tests */

// We test only the toEntity() function
final class ProductDTOTests: XCTestCase {

    func testProductDTOToEntityConversion() {
        let dto = ProductDTO(
            product_id: 1,
            product_name: "Shampoo",
            description: "Hair product",
            price: 10.99,
            image_url: ProductImageURL(small: "small.jpg", large: "large.jpg"),
            c_brand: ProductBrand(id: "123", name: "L'Oréal"),
            is_productSet: false,
            is_special_brand: true
        )

        let entity = dto.toEntity()

        XCTAssertEqual(entity.product_id, 1)
        XCTAssertEqual(entity.product_name, "Shampoo")
        XCTAssertEqual(entity.image_url?.small, "small.jpg")
        XCTAssertEqual(entity.c_brand?.name, "L'Oréal")
        XCTAssertTrue(entity.is_special_brand)
    }
}

// We test only the fetchProductListPage function
final class ProductListPageViewRepositoryTests: XCTestCase {

    func testFetchProductListPageWhenalreadyCache() async throws {
        
        let fakeProductDTO = ProductDTO(
            product_id: 1,
            product_name: "Cached Product",
            description: nil,
            price: 5.0,
            image_url: nil,
            c_brand: nil,
            is_productSet: false,
            is_special_brand: false
        )

        let memoryCache = MockMemoryCacheService(data: [fakeProductDTO])
        let repo = ProductListPageViewRepositoryImpl(apiService: MockAPI(), memoryCacheService: memoryCache)

        let result = try await repo.fetchProductListPage()
        XCTAssertEqual(result.first?.product_name, "Cached Product")
    }
}

// We test both execute function that include de orderProductsWithSpecialBrandFirstFrom function
final class ProductListPageUseCaseTests: XCTestCase {

    func testOrderProductsWithSpecialBrandFirst() async throws {
        let normal = ProductEntity(product_id: 1, product_name: nil, description: nil, price: nil, image_url: nil, c_brand: nil, is_productSet: false, is_special_brand: false)
        let normal2 = ProductEntity(product_id: 2, product_name: nil, description: nil, price: nil, image_url: nil, c_brand: nil, is_productSet: false, is_special_brand: false)
        let special = ProductEntity(product_id: 3, product_name: nil, description: nil, price: nil, image_url: nil, c_brand: nil, is_productSet: false, is_special_brand: true)
        let normal3 = ProductEntity(product_id: 4, product_name: nil, description: nil, price: nil, image_url: nil, c_brand: nil, is_productSet: false, is_special_brand: false)

        let useCase = ProductListPageViewUseCaseImpl(productListPageViewRepository: MockRepo(productFectch:  [normal, normal2, special, normal3]))
        let sorted = try await useCase.execute()

        XCTAssertEqual(sorted.first?.product_id, 3)
    }
}
