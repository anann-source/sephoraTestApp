//
//  PLPViewModel.swift
//  ProductListingPage
//
//  Created by Chuon Anann on 03/05/2025.
//

import SwiftUI

public protocol ProductListPageViewModel: Sendable {
    func fetchProductListInfo() async
    func pageTitle() async -> String
}

/* Intermediate models between view and view model, to build precisely complexe views organisation */
enum ProducListViewItem: Identifiable {
    var id: UUID { UUID() }
    case contentCellItem(ContentCellItemData)
    case footer(String)
    case header(String)
}

typealias ContentCellItemData = (name: String, description: String, price: String)

@MainActor
public class ProductListPageViewModelImpl: ProductListPageViewModel, ObservableObject {
  
    private var productList: [ProductEntity] = []
    @Published var productListViewsItems: [ProducListViewItem] = []

    private let productListPageViewUseCase: ProductListPageViewUseCase
    
    public init(productListPageViewUseCase: ProductListPageViewUseCase) {
        self.productListPageViewUseCase = productListPageViewUseCase
    }
    
    public func fetchProductListInfo() async {
        do {
            productList = try await productListPageViewUseCase.execute()
            productListViewsItems = buildProductListViewItems()
        } catch {
            debugPrint(".\(error)") // TODO: handle error UI
        }
    }

    public func pageTitle() -> String {
        return "Product List Page"
    }
    
    // Build view items, we use intermediate view item to make the order of building elements easier
    private func buildProductListViewItems() -> [ProducListViewItem] {
        var producListViewItems: [ProducListViewItem] = []
        
        // Statique header view item
        producListViewItems.append(ProducListViewItem.header("Header, Push me to test the cache"))

        // Product cells items
        let viewItemsFromProductList = productList.map {
            let contentCellItemData = ContentCellItemData(name: $0.product_name ?? "", description: $0.description ?? "", price: ".\($0.price ?? 0.0)€")
            return ProducListViewItem.contentCellItem(contentCellItemData)
        }
        
        if !viewItemsFromProductList.isEmpty { producListViewItems += viewItemsFromProductList }
        
        // Statique footer view item
        producListViewItems.append(ProducListViewItem.footer("Statique Footer"))

        return producListViewItems
    }
}
