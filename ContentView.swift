import SwiftUI
import UIKit
import WebKit

struct ContentView: View {
    var body: some View {
        LocalStudyWebView()
            .ignoresSafeArea(.container, edges: [.bottom])
            .background(Color(red: 0.035, green: 0.035, blue: 0.04))
    }
}

private struct LocalStudyWebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.04, alpha: 1)
        webView.scrollView.backgroundColor = webView.backgroundColor
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = true

        if let indexURL = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL.deletingLastPathComponent())
        } else {
            let html = """
            <!doctype html><html lang="cs"><meta name="viewport" content="width=device-width,initial-scale=1">
            <body style="background:#101014;color:#fff;font:16px -apple-system;padding:24px">
            <h1>Soubor index.html nebyl nalezen</h1>
            <p>Zkontroluj, že je v kořeni repozitáře soubor index.html a že proběhlo sestavení projektu.</p>
            </body></html>
            """
            webView.loadHTMLString(html, baseURL: nil)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
