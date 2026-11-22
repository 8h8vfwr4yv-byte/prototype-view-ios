import SwiftUI
import WebKit

@main
struct PrototypeViewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

let targetURL = URL(string: "https://www.axureshow.com/project/R6MecepB/")!

final class WebViewStore: ObservableObject {
    let webView: WKWebView

    init() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: targetURL))
    }

    func reload() { webView.reload() }
    func goHome() { webView.load(URLRequest(url: targetURL)) }
}

struct WebViewRepresentable: UIViewRepresentable {
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView { webView }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView: View {
    @StateObject private var store = WebViewStore()
    @State private var canGoBack = false
    @State private var canGoForward = false

    var body: some View {
        VStack(spacing: 0) {
            WebViewRepresentable(webView: store.webView)
                .ignoresSafeArea(edges: .top)
                .onReceive(Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()) { _ in
                    canGoBack = store.webView.canGoBack
                    canGoForward = store.webView.canGoForward
                }
            HStack(spacing: 26) {
                Button {
                    store.webView.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!canGoBack)

                Button {
                    store.webView.goForward()
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!canGoForward)

                Spacer()

                Button {
                    store.reload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }

                Button {
                    store.goHome()
                } label: {
                    Image(systemName: "house")
                }

                Button {
                    UIApplication.shared.open(targetURL)
                } label: {
                    Image(systemName: "safari")
                }
            }
            .font(.system(size: 18))
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
        }
    }
}
