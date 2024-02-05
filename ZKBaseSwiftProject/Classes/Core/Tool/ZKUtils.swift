//
//  ZKUtils.swift
//  ZKBaseSwiftProject
//
//  Created by 高广校 on 2023/12/28.
//

import Foundation
import GGXSwiftExtension
import WebKit
import KeychainAccess

public struct ZKUtils {
    
    public static var deviceIdentifier: String = {
        return ZKUtils.getDeviceIdentifier()
    }()
 
    /// 获取设备的UUID
    /// - Returns: UUID的字符串
    static func getUUID() -> String {
        return UUID().uuidString
    }
    
    /// 获取设备的UUID ，此UUID与BundleID绑定，为设备的唯一ID
    /// - Returns: 返回设备唯一标识符
    static func getDeviceIdentifier() -> String{
//        let bundleID : String = Bundle.main.infoDictionary?[(kCFBundleIdentifierKey as NSString) as String] as! String
        let bundleID = kAppBundleId ?? "rs.com"
        let service = bundleID + "\(#function)"
        let keychainItems = Keychain(service :service).allItems()
        var deviceID : String = ""
        if keychainItems.count > 0 {
            deviceID = keychainItems[0]["value"] as! String
        }
        if  deviceID.isEmpty {
            deviceID = getUUID()
            Keychain(service:service)["bundleID"] = deviceID
        }
        return deviceID
    }
    
    public static func getbaseUA(name: String) -> String {
        let appVersion = kAppVersion ?? ""
        let appBuildVersion = kAppBuildVersion ?? ""
        return deviceUserAgent + " \(name)/" + appVersion + " Build/" + appBuildVersion +  " Factory/apple"
    }
    
    public static var deviceUserAgent: String {
        let systemVersion = UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")
        var systemName = ""
        if UIDevice.isIPad {
            systemName = "OS"
        } else {
            systemName = "iPhone OS"
        }
        let newUA = "Mozilla/5.0 (\(UIDevice.current.model); CPU \(systemName) \(systemVersion) like Mac OS X; \(UIDevice.modelName)) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
        return newUA
    }
    
    static func removeWebsiteDataStore() {
//        WKWebsiteDataStore.removeWebsiteDataStore()
    }
}

public typealias DispatchTask = (_ cancel: Bool) -> Void
@discardableResult
public func delay(time: TimeInterval, task: @escaping ()->(), queue: DispatchQueue = DispatchQueue.main) -> DispatchTask? {
    func dispatch_later(block: @escaping ()->()) {
        queue.asyncAfter(deadline: DispatchTime.now() + time, execute: block)
    }
    var closure: (()->Void)? = task
    var result: DispatchTask?
    let delayedClosure: DispatchTask = { cancel in
        if let internalClosure = closure {
            if !cancel {
                queue.async {internalClosure()}
            }
        }
        closure = nil
        result = nil
    }
    result = delayedClosure
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

public func cancel(task: DispatchTask?) {
    task?(true)
}
