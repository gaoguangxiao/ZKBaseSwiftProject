//
//  JKWebView.swift
//  ZKBaseSwiftProject_Example
//
//  Created by 高广校 on 2024/3/12.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import ZKBaseSwiftProject

struct JKWebView: View {
    @available(iOS 13.0, *)
    var body: some View {
        
        GXWKWebView(url: "https://www.baidu.com")
    }
}

#Preview {
    JKWebView()
}
