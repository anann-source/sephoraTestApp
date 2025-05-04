//
//  Footer.swift
//  DesignSystem
//
//  Created by Chuon Anann on 04/05/2025.
//

import SwiftUI

public struct FooterView: View {
    
    var footerText: String?
    
    public init(footerText: String) {
        self.footerText = footerText
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if let footerText {  Text(footerText) }
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
        .background(Color(.red))
    }
}

#Preview {
    FooterView(footerText: "footer")
}
