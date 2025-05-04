
import SwiftUI
import DesignSystem

public struct ProductListPageView: View {
    
    @ObservedObject var viewModel: ProductListPageViewModelImpl
    
    public init(viewModel: ProductListPageViewModelImpl) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.productListViewsItems) { viewItem in
                    // We use enums data to avoid if else
                    switch viewItem {
                    case .contentCellItem(let item):
                        ProductCell(title: item.name, subtitle: item.description, info: item.price)
                        
                    case .footer(let item):
                            FooterView(footerText: item)
                        
                    case .header(let item):
                        NavigationLink(destination: DetailView(item: "A push to test the cache")) {
                            HeaderView(headerText: item)
                        }
                    }
                }
            }
        }
        .padding(0)
        .navigationTitle(viewModel.pageTitle())
        .task {
            await self.viewModel.fetchProductListInfo()
        }
    }
}

// Test View just to test the cache
struct DetailView: View {
    var item: String
    var body: some View {
        Text("Go back to test the caching")
    }
}
