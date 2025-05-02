import Foundation

struct Article: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let source: Source
    
    struct Source: Decodable {
        let name: String
    }
}

struct NewsResponse: Decodable {
    let articles: [Article]
}
