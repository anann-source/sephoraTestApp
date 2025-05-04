import SwiftUI

public struct ProductCell: View {
    
    var title: String?
    var subtitle: String?
    var info: String?

    public init(title: String?, subtitle: String?, info: String?) {
        self.title = title
        self.subtitle = subtitle
        self.info = info
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if let title {  Text(title) }
            if let subtitle { Text(subtitle) }
            if let info { Text(info) }
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
        .background(Color(.lightGray))
        .cornerRadius(10)
    }
}

#Preview {
    ProductCell(title: "aa", subtitle: "bb", info: "cc")
}
