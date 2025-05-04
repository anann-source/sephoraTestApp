import Foundation

public protocol NetworkService {
    func fetchData(from url: URL) async throws -> Data
}

public struct NetworkServiceImpl: NetworkService {
    
    public init() {}
    
    public func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
