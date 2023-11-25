//
//  ZKBaseWKWebViewController.swift
//  RSReading
//
//  Created by 高广校 on 2023/9/12.
//

import UIKit
import WebKit
//import RxCocoa
import GGXSwiftExtension

let kWebviewEstimatedProgressValue = "kWebviewEstimatedProgressValue"

//定义JS交互闭包
//public typealias WKScriptMessageClosure = (WKScriptMessage,Int) -> Void

open class ZKBaseWKWebViewController: ZKBaseViewController {

    //执行回调
    public var scriptMessageClose: WKScriptMessageClosure?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        self.buildUI()
    }
    
    func buildUI() {
        webView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(0)
            maker.trailing.equalTo(0)
            maker.top.equalTo(TopBarHeight)
            maker.bottom.equalTo(0)
        }
    }
    
    //自定义UA
//    func setUA(customUserAgent: String) -> Self {
//        self.webView.customUserAgent = customUserAgent
//        return self
//    }
//    
//    func addUserScript(forSource source: String) -> Self {
//        let userScript: WKUserScript = WKUserScript.init(source: source, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
//        webView.configuration.userContentController.addUserScript(userScript)
//        return self
//    }
//    
//    func addScriptMessage(name: String,jsBridge:@escaping WKScriptMessageClosure) {
//        let userContentController = webView.configuration.userContentController
//        if #available(iOS 14, *){
//            let messageBridge = GXMessageBridge(scriptWithReplyDelegate: self)
//            userContentController.addScriptMessageHandler(messageBridge, contentWorld: .page, name: name)
//        } else {
//            let messageBridge = GXMessageBridge(self)
//            userContentController.add(messageBridge, name: name)
//        }
//    }
    
    deinit {
        print("\(self)dealloc")
    }
    
    public var _userContentController: WKUserContentController?
    
    public lazy var webView: WKWebView = {
        let conf = WKWebViewConfiguration()
        
        let preferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        if #available(iOS 13.0, *) {
            let pagePreferences = WKWebpagePreferences()
            if #available(iOS 14.0, *) {
                pagePreferences.allowsContentJavaScript = true
            } else {
                // Fallback on earlier versions
//                pagePreferences.preferredContentMode = .desktop
            }
            conf.defaultWebpagePreferences = pagePreferences
        } else {
            // Fallback on earlier versions
            preferences.javaScriptEnabled = true
        }
        conf.preferences = preferences
        conf.userContentController = WKUserContentController()
        //配置
        conf.allowsInlineMediaPlayback = true
//        conf.requiresUserActionForMediaPlayback = false
        conf.allowsAirPlayForMediaPlayback = false
        _userContentController = conf.userContentController
        
        let webView = WKWebView(frame: .zero, configuration: conf)
        webView.navigationDelegate = self
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        } else {
            // Fallback on earlier versions
        }
//        webView.scrollView.delegate = self
        webView.scrollView.bounces = false
        webView.allowsLinkPreview = false
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        }
        return webView
    }()
    
    public var urlString: String = "" {
        didSet{
            guard urlString.count > 0 else {
                return
            }
            
            if let url = URL.init(string: urlString) {
                ZKLog("web url is: \(urlString)")
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
                webView.load(request)
            }
        }
    }
}

extension ZKBaseWKWebViewController: WKNavigationDelegate, UIScrollViewDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let _urlString = navigationAction.request.url?.absoluteString.removingPercentEncoding ?? ""
        guard _urlString.count > 0 else {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ZKLog("web view begin loading main fram ...")

    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ZKLog("web view did finish navigation ...\(Date.milliStamp)")
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let code = (error as NSError).code
        if  code == NSURLErrorCancelled {
            return
        }
        ZKLog("加载失败~error = \(error)")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       
        let code = (error as NSError).code
        if  code == NSURLErrorCancelled {
            return
        }
        ZKLog("加载失败 error = \(error)")
    }
}

//extension ZKBaseWKWebViewController: WKScriptMessageHandler , WKScriptMessageHandlerWithReply{
//    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("old iOS 14---\(message.body)")
//    }
//    
//    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
//        //        XXX.handJS.re
//        if let close = self.scriptMessageClose {
//            close(message,0)
//        }
//        
//        //完成回调
//        //        replyHandler(,)
//        //        print("---\(message.body)")
//    }
//    
//    //处理JS->iOS 交给bridge处理
//}
