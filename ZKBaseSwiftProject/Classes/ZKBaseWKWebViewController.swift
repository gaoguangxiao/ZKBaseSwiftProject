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

public protocol WKWebScriptMessageDelegate: NSObjectProtocol {
    
    func zkuserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage);
    
    @available(iOS 14.0, *)
    func zkUserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void);
        
}

open class ZKBaseWKWebViewController: ZKBaseViewController {
    
    //执行回调
    public weak var scriptMessageDelegate: WKWebScriptMessageDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(webView)
        self.buildUI()
    }
    
    open func buildUI() {
        webView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(0)
            maker.trailing.equalTo(0)
            maker.top.equalTo(TopBarHeight)
            maker.bottom.equalTo(0)
        }
    }
    
    //自定义UA
    public func setUA(customUserAgent: String) {
        self.webView.customUserAgent = customUserAgent
    }
    
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
                let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
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
    
//    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//    
//        print("webViewWebContentProcessDidTerminate:\(webView)")
//    }
    
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod
            == NSURLAuthenticationMethodServerTrust {
            // 告诉服务器，客户端信任证书
            // 创建凭据对象
            let card = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            // 告诉服务器信任证书
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, card)
        }
    }
}

public extension ZKBaseWKWebViewController {
    
    func addUserScript(forSource source: String,injectionTime: WKUserScriptInjectionTime = .atDocumentStart, forMainFrameOnly: Bool = false) {
        let userScript: WKUserScript = WKUserScript.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        webView.configuration.userContentController.addUserScript(userScript)
    }
    
    func addScriptMessage(name: String) {
        let userContentController = webView.configuration.userContentController
        if #available(iOS 14, *){
            let messageBridge = GXMessageBridge(scriptWithReplyDelegate: self)
            userContentController.addScriptMessageHandler(messageBridge, contentWorld: .page, name: name)
        } else {
            let messageBridge = GXMessageBridge(self)
            userContentController.add(messageBridge, name: name)
        }
    }
    
    func evaluateJavaScript(_ javaScriptString: String) {
        self.webView.evaluateJavaScript(javaScriptString)
    }
}


extension ZKBaseWKWebViewController: WKScriptMessageHandler , WKScriptMessageHandlerWithReply {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.scriptMessageDelegate?.zkuserContentController(userContentController, didReceive: message)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        if #available(iOS 14.0, *) {
            self.scriptMessageDelegate?.zkUserContentController(userContentController, didReceive: message, replyHandler: replyHandler)
        } else {
            // Fallback on earlier versions
        }
    }
}

//extension ZKBaseWKWebViewController: WKWebScriptMessageDelegate {
//    open func zkUserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
//        
//    }
//}
