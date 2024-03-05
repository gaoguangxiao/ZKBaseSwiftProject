//
//  KJLoginViewController.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2023/11/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import PKHUD
import ZKBaseSwiftProject
import SwiftUI
import Combine

@available(iOS 13.0, *)
class KJLoginViewController: AppBaseViewController {

    var clickSkipCancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view => preLoginbtn
        preLoginbtn.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    @objc func gotoLogin()  {
//        ZKLog("跳转登录")
//        let vc = PPSMSLoginController()
//        push(vc)
//        HUD.flash()
//        HUD.flash("加载失败~")
//        self.navigationController?.pushViewController(vc, animated: true)
        
        //调试
        if #available(iOS 13.0, *) {
            let payV = SwiftUISMSQrCodeViewVc(qrName: "weixin://wxpay/bizpayurl?pr=zNiKxjQzz")
            self.push(payV)
//            let image = UIImage.createQRCode(qrCode: "weixin://wxpay/bizpayurl?pr=zNiKxjQzz", szie: CGSizeMake(100, 100))
            
//            var view = SwiftUISMSQrCodeView(qrImage: image,countdown: 5)
//            let vc = UIHostingController(rootView: view)
//            view.payResult = PayEventHandler()
            
            
//            view.payResult = {
//                
//                print("pay end result")
//                
//                
//                vc.navigationController?.popViewController(animated: false)
////                ?.pop()
//    //            self?.pop()
//            }
//            self.clickSkipCancellable = 
//            view.payResult.$payResult.sink(receiveValue: {_ in
//                print("pay end result")
//                
//            })
//            
//            self.push(vc)
        } else {
            // Fallback on earlier versions
        }
        
//        let payView = SwiftUISMSQrCodeView()
//        let payV  = UIHostingController(rootView: payView)
        
    }
    
    lazy var preLoginbtn = UIButton().zkSetNormalTitle("跳转").zkSetTitleColor(.zk333333).zkAction(self, action: #selector(gotoLogin))

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
