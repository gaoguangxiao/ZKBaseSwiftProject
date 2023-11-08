//
//  KJHomeViewController.swift
//  gxx-swiftkj
//
//  Created by 高广校 on 2023/9/11.
//

import Foundation
import GGXSwiftExtension
import ZKBaseSwiftProject
import UIKit
class KJHomeViewController: ZKBaseWKWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        //WKWeb练习
        self.urlString = "https://www.baidu.com"
     
        self.webView.customUserAgent = deviceUserAgent
        /**
         *
         显示在用户代理字符串中的应用程序名称。
         * Mobile/15E148
         */
        let wkConappName = self.webView.configuration.applicationNameForUserAgent
        print(wkConappName)
    }
    
    var deviceUserAgent: String {
        var systemVersion = UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")
        var systemName = ""
        if UIDevice.isIPad {
            systemName = "OS"
        } else {
            systemName = "iPhone OS"
        }
        var newUA = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(systemName) \(systemVersion) like Mac OS X; \(UIDevice.modelName)) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
        let appVersion = kAppVersion ?? ""
        let appBuildVersion = kAppBuildVersion ?? ""
        newUA +=  " Adventure/" + appVersion + " Build/" + appBuildVersion +  " Factory/apple" + " Channel/dev"
        return newUA
    }
    
    @objc func didAction()  {
        print("ddd")
    }
    
    lazy var btn: UIButton = {
        var lBtn = UIButton(type: .custom)
        lBtn.setTitle("加载网络", for: .normal)
        lBtn.setTitleColor(.black, for: .normal)
        lBtn.addTarget(self, action: #selector(didAction), for: .touchUpInside)
        return lBtn
    }()
}
