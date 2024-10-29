import SwiftUI
import WebKit

struct ContentView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        WebView(searchText: searchText, isSearching: $isSearching)
    }
}

struct WebView: UIViewRepresentable {
    let searchText: String
    @Binding var isSearching: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        loadInitialURL(in: webView)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard isSearching else { return }
        performSearch(in: webView)
        isSearching = false
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    private func loadInitialURL(in webView: WKWebView) {
        guard let url = URL(string: "https://www.google.com") else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func performSearch(in webView: WKWebView) {
        guard let encodedQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.google.com/search?q=\(encodedQuery)") else { return }
        webView.load(URLRequest(url: url))
    }
}

class Coordinator: NSObject, WKNavigationDelegate { }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 7"))
    }
}
