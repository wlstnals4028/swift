import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView()
    }
}

struct WebView: UIViewRepresentable {
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        
        loadInitialURL(in: webView)
        return webView
    }
    
    private func loadInitialURL(in webView: WKWebView) {
        guard let url = URL(string: "https://www.google.com") else { return }
        webView.load(URLRequest(url: url))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 7"))
    }
}
