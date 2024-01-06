//
//  WebView.swift
//  GitHubBrowser
//
//  Created by Franck Petriz on 06/01/2024.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    private let webViewURL: URL?

    public init(webViewURL: URL?) {
        self.webViewURL = webViewURL
    }

    public func makeUIView(context _: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }

    public func updateUIView(
        _ webView: WKWebView,
        context _: Context
    ) {
        guard let url = webViewURL else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
