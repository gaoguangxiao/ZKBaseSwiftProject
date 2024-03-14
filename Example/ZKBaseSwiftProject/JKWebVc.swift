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
        
        //增加JS监听
        self.scriptMessageDelegate = self
        self.addScriptMessage(name: "JSBridge")
        
        //WKWeb
        self.urlString = "http://127.0.0.1:5500/loadPkg.html"
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
