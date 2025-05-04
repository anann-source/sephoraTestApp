//
//  Header.swift
//  DesignSystem
//
//  Created by Chuon Anann on 04/05/2025.
//

import SwiftUI

public struct HeaderView: View {
    
    var headerText: String?
    
    public init(headerText: String) {
        self.headerText = headerText
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if let headerText {  Text(headerText) }
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
        .background(Color(.blue))
    }
}

#Preview {
    HeaderView(headerText: "header")
}
