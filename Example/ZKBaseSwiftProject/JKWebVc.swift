//
//  JKWebVc.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2023/11/27.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import ZKBaseSwiftProject
import WebKit

class JKWebVc: ZKBaseWKWebViewController {
    
    @IBOutlet weak var callWebBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //将回调按钮修饰最前面
        view.bringSubviewToFront(callWebBtn)
//        callWebBtn.br
        
        self.setUA(customUserAgent: "test")
        
        //注入JS代码
//        let jsCode = """
//                var nativeBridge = new Object();
//                nativeBridge.postMessage = function(params) {
//                return window.webkit.messageHandlers.postMessage.postMessage({params});
//                }
//                """
//        self.addUserScript(forSource: jsCode,forMainFrameOnly: false)

        //增加JS监听
        self.scriptMessageDelegate = self
        self.addScriptMessage(name: "JSBridge")
        
        //WKWeb
        self.urlString = "http://localhost:8081/zkweb/test.html"
        

        self.setUA(customUserAgent: ZKUtils.deviceUserAgent)
        //原生和web交互中，由监听JS方法，响应之后通过`evaluateJavaScript`向web发送消息；
        //iOS14之后，监听JS方法，可以在监听方法中`replyHandler`直接给回调，
//        不需要调用`evaluateJavaScript`，也就不需要自定义实现JS方法的回调
        
        //        let wkConappName = self.webView.configuration.applicationNameForUserAgent
        //        print(wkConappName)
        
    }
    
    @IBAction func 给Web回调(_ sender: Any) {
        //调用Web方法
        let calljs = "try{JSBridge.callWeb(\(12))}catch(e){console.log(e)}"
        self.evaluateJavaScript(calljs)
    }
    
    //    var deviceUserAgent: String {
//        var systemVersion = UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")
//        var systemName = ""
//        if UIDevice.isIPad {
//            systemName = "OS"
//        } else {
//            systemName = "iPhone OS"
//        }
//        var newUA = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(systemName) \(systemVersion) like Mac OS X; \(UIDevice.modelName)) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
//        let appVersion = kAppVersion ?? ""
//        let appBuildVersion = kAppBuildVersion ?? ""
//        newUA +=  " Adventure/" + appVersion + " Build/" + appBuildVersion +  " Factory/apple" + " Channel/dev"
//        return newUA
//    }
    
    func callJS() {
        let calljs = "try{JSBridge.callWeb(\(12))}catch(e){console.log(e)}"
        self.evaluateJavaScript(calljs)
    }
}

extension JKWebVc: WKWebScriptMessageDelegate {
    
    func zkuserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    func zkUserContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage, replyHandler: @escaping (Any?, String?) -> Void) {
        
        print(message.name + "\(message.body)")
        
        //第一种方式
//        self.callJS()
        
        //下面可选实现，必须iOS14之后
        replyHandler("回复的值",nil)
    }
    
}
