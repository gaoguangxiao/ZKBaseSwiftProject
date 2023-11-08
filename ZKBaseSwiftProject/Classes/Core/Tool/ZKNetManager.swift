//
//  ZKNetManager.swift
//  ZKNASProj
//
//  Created by 董建伟 on 2022/11/7.
//

import UIKit

class ZKNetManager: NSObject {

//    static func isReachable() -> Bool {
//        return AFNetworkReachabilityManager.shared().isReachable
//    }
}


func addTaskToMainThread(_ task: @escaping ()->()) {
    if Thread.isMainThread {
        task()
    } else {
        DispatchQueue.main.async {
            task()
        }
    }
}
