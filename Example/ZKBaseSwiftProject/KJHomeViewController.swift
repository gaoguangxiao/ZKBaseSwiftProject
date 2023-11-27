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
class KJHomeViewController: ZKBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
    }
    
    @objc func didAction()  {
        push(JKWebVc())
    }
  
    lazy var btn: UIButton = {
        var lBtn = UIButton(type: .custom)
        lBtn.setTitle("打开Web界面", for: .normal)
        lBtn.setTitleColor(.black, for: .normal)
        lBtn.addTarget(self, action: #selector(didAction), for: .touchUpInside)
        return lBtn
    }()
}
