//
//  ContentView.swift
//  SephoraApp
//
//  Created by Chuon Anann on 03/05/2025.
//

import SwiftUI
import ProductListingPage
import Networking
import Persistance

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ProductListPageView(viewModel: ProductListPageViewModelImpl(productListPageViewUseCase: ProductListPageViewUseCaseImpl(productListPageViewRepository: ProductListPageViewRepositoryImpl(apiService: ApiServiceImpl(networkService: NetworkServiceImpl()), memoryCacheService: MemoryCacheServiceImpl()))))
            }
        }
    }
}

#Preview {
    ContentView()
}
