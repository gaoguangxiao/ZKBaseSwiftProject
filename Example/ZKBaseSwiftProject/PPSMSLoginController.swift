//
//  PPSMSLoginController.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2023/11/8.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import ZKBaseSwiftProject
class PPSMSLoginController: AppBaseViewController {

    let smsLoginView = ZKBaseView()
    
    override func loadView() {
       view = smsLoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let btn = UIButton(type: .custom)
        view => btn
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
