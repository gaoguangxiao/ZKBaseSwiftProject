//
//  ZKAdapt.swift
//  ZKNASProj
//
//  Created by 董建伟 on 2022/11/3.
//

import Foundation
import UIKit
extension CGFloat {
    /// 返回对应设备匹配的尺寸
    func tdMatch() -> CGFloat{
        return CGFloat(self) / 375.0 * (UIScreen.main.bounds.size.width)
    }
}


extension Double {
    /// 返回对应设备匹配的尺寸
    func tdMatch() -> CGFloat {
        return CGFloat(self) / 375.0 * (UIScreen.main.bounds.size.width)
    }
}


public extension Int {
    /// 返回对应设备匹配的尺寸
    func zkMatch() -> CGFloat {
        return CGFloat(self) / 375.0 * (UIScreen.main.bounds.size.width)
    }
}
