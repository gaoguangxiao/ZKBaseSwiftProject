//
//  ZKBaseViewController.swift
//  ZKNASProj
//
//  Created by 董建伟 on 2022/10/21.
//

import UIKit
//import RxSwift
import SnapKit
open class ZKBaseViewController: UIViewController  {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationBar()
        
    }
    
}


extension ZKBaseViewController: ZKNavigationViewProtocol {
    
    func navigationTitle() -> String? {
        return nil
    }
    
    func hiddenNavigationBar() -> Bool {
        return false
    }
    
    func backItemAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

