//
//  RSURLSchemeHander.swift
//  RSReading
//
//  Created by 高广校 on 2023/11/8.
//

import Foundation
import WebKit

open class ZKURLSchemeHandler: NSObject {
    
}

@available(iOS 11.0, *)
extension ZKURLSchemeHandler: WKURLSchemeHandler{
    open func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        print("ZK拦截请求")
    }
    
    open func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        
    }
}
