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

open class ZKBaseWKWebViewController: ZKBaseViewController {

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
        conf.requiresUserActionForMediaPlayback = false
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
//                self.webViewWillLoadNewRequest()
                ZKLog("web url is: \(urlString)")
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
                webView.load(request)
            }
        }
    }
}

extension ZKBaseWKWebViewController: WKNavigationDelegate, UIScrollViewDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let _urlString = navigationAction.request.url?.absoluteString.removingPercentEncoding ?? ""
        guard _urlString.count > 0 else {
            decisionHandler(.cancel)
            return
        }
        
//        if let urlList = UserDefaults.standard.array(forKey: URI_WHITE_LIST) {
//            for item in urlList {
//                if _urlString.hasPrefix(item as! String) {
//                    if let url = URL.init(string: _urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
//                        UIApplication.shared.openURL(url)
//                        decisionHandler(.cancel)
//                        return
//                    }
//                }
//            }
//        } else {
//            for item in urlSchemes {
//                if _urlString.hasPrefix(item) {
//                    if let url = URL.init(string: _urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "") {
//                        UIApplication.shared.openURL(url)
//                        decisionHandler(.cancel)
//                        return
//                    }
//                }
//            }
//        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ZKLog("web view begin loading main fram ...")
//        if showLoading {
//            MSBHUDManager.showHUD(info: "加载中...")
////            MSBHUDManager.loading("加载中...", on: self.view)
//        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ZKLog("web view did finish navigation ...\(Date.milliStamp)")
//        self.callJS(action:"bridgeReady")
//        if showLoading {
//            HUD.hide()
//        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let code = (error as NSError).code
        if  code == NSURLErrorCancelled {
            return
        }
//        self.loadErrorView.showOnView(self.view) {[weak self] in
//            guard let `self` = self else { return }
////            addTaskToMainThread {
////                let url = self.urlString
////                self.urlString = url
////                self.loadErrorView.hidden()
////            }
//        }
//        HUD.flash("加载失败")
        ZKLog("加载失败~error = \(error)")
        
//        PTTracker.track(event: "webview_error", attributes: ["url" : webView.url?.absoluteString ?? self.urlString , "error" : "didFailProvisionalNavigation = \(error.localizedDescription)" ])

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       
        let code = (error as NSError).code
        if  code == NSURLErrorCancelled {
            return
        }
//        HUD.flash("加载失败")
        ZKLog("加载失败 error = \(error)")
               
//        PTTracker.track(event: "webview_error", attributes: ["url" : webView.url?.absoluteString ?? self.urlString , "error" : "didFail = \(error.localizedDescription)" ])

    }
}
