import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        if let urlString = article.url, let url = URL(string: urlString) {
                            UIApplication.shared.open(url)
                        }
                    }
            }
            .navigationTitle("Daily News")
            .onAppear {
                viewModel.fetchNews()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading news...")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
