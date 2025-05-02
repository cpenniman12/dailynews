import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    
    func fetchNews() {
        isLoading = true
        
        // You'll need to replace this with your own API key
        // from https://newsapi.org/
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_API_KEY") else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { 
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = result.articles
                    }
                } catch {
                    print("Failed to decode: \(error)")
                    // For testing, populate with sample data if API fails
                    DispatchQueue.main.async {
                        self.articles = self.sampleArticles
                    }
                }
            } else {
                // Load sample data if network request fails
                DispatchQueue.main.async {
                    self.articles = self.sampleArticles
                }
            }
        }.resume()
    }
    
    // Sample data for preview and testing
    var sampleArticles: [Article] = [
        Article(
            title: "Sample headline about technology",
            description: "This is a sample article description about the latest technology news.",
            url: "https://example.com",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: "2025-05-02T12:00:00Z",
            source: Article.Source(name: "Tech News")
        ),
        Article(
            title: "Important world events today",
            description: "A summary of the most important world events happening today.",
            url: "https://example.com",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: "2025-05-02T10:30:00Z",
            source: Article.Source(name: "World News")
        ),
        Article(
            title: "Sports results from yesterday",
            description: "All the major sports results from games played yesterday.",
            url: "https://example.com",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: "2025-05-01T22:15:00Z",
            source: Article.Source(name: "Sports Center")
        )
    ]
}
