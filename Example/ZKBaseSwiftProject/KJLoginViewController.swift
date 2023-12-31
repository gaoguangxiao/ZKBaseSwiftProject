//
//  KJLoginViewController.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2023/11/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import ZKBaseSwiftProject

class KJLoginViewController: AppBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view => preLoginbtn
        preLoginbtn.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    @objc func gotoLogin()  {
        ZKLog("跳转登录")
        let vc = PPSMSLoginController()
        push(vc)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var preLoginbtn = UIButton().zkSetNormalTitle("跳转登录").zkSetTitleColor(.zk333333).zkAction(self, action: #selector(gotoLogin))

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
