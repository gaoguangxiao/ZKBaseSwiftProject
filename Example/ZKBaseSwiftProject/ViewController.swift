//
//  ViewController.swift
//  ZKBaseSwiftProject
//
//  Created by 小修 on 09/14/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import ZKBaseSwiftProject
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

struct UpdateSpinView: View {
    
    var body: some View {
        
        Button {
            
        } label: {
            Text("窗户")
        }

    }
}

//使用实例
class GXRecordExcelViewController: ZKBaseHostingVc<UpdateSpinView> {
    
    public init(excels: Array<UpdateSpinView>) {
        let view = UpdateSpinView()
        super.init(rootView: view)
        self.modalPresentationStyle = .fullScreen
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func backBtnClick() {
        print("返回")
//        self.dis()
        self.dismiss(animated: false)
    }
}
